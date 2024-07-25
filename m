Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE0EAC0
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905339; cv=none; b=noWff6ULFVk3bVyvbbiJI7z1jxMW6zt2M0CcIHu80QIuT+UjmHBD9mdjes/GKrKOF+AHgvTmbOG8Ml+RK4jb25VoGzaDfVJAKKIkpgOActkHnf3QbFiOOUbJehv6pq7Hluvh2w4FaI6Up2M4E9oqgbQEarTlhidcBv0mAGTcjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905339; c=relaxed/simple;
	bh=uTEzl1DGTtt5PC7rNqFp3gSJItEkihIT3JivE6CRMMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpbpLjYWYriW3ho1Q8I4C39r/ncwdpBuomI2sWwY18Fmh8HSBJrdrUPClXS4mJE/JnBQ8dFd81MkgqNbyy/xxEzca4PrLlAxJIjY/FgJSCb4TGua1a3ZaExx9LWnkrsgYp4l4RvZSKMhARS0UuENSLHA9hDsSNZXax1gmmE/ySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.185])
	by sina.com (10.185.250.21) with ESMTP
	id 66A2307E00007549; Thu, 25 Jul 2024 19:01:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5484873408034
X-SMAIL-UIID: 45E6E71375B7484FB64D4B461277FD71-20240725-190122-1
From: Hillf Danton <hdanton@sina.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	tj@kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Thu, 25 Jul 2024 19:01:11 +0800
Message-Id: <20240725110111.2063-1-hdanton@sina.com>
In-Reply-To: <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jul 2024 09:48:36 +0800 Chen Ridong <chenridong@huawei.com>
>
> did you mean to say this issue couldn't happen?
>
1) It is deadlock if watchdog work can not complete before any cgroup work.
2) It is not if you could not trigger it with no more than a dozen cgroup works.

Not important, boy, spin with deadlock erased.
