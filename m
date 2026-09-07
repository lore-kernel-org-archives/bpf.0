Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95533F589
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758086; cv=none; b=S6fraNyl/OU8XYkRdabYSRZvOxq6xg0wG2tSGoX5GXVMfcEg6vMQUrt5XaG90l0RuZKLBhr8W7gUIDClorD4wzZL16UQjI6PbPBR7VduQHNkiLc9yMNmbsfFb6J/tBmBeiYvS49BDEkFRtclcwGBk5ZbX1wHpit/dv02eTXWQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758086; c=relaxed/simple;
	bh=VIgjKHYjIZWMXIc+aVfcwlKlcjgBtNshGeMavwN4BC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dx1KYM7QqvQR1duQ9RcCknxFO/wMZYrh/qkZ59nKsNCVXXydGDZO4rN093sGGLiHzEbmFW44pIwirCw/mL33YDwJXmyFRgI3nSfEMDPstJdM82HQVF/fNh9PGp68bXX67+nXzgKUwXbN8sSnjfQDxBc4UUv922Cu4f0KwMsVCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=THbq9lSr; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="THbq9lSr"
Received: from fedora (unknown [23.142.132.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdZxk6nSrz2xBk;
	Mon, 07 Sep 2026 05:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788758076;
	bh=h/MQHaS9ne2VaLB2qbTvVez4UnCJMtYEo3zO18uCQ44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THbq9lSrWz9VS+fisrWmkVxzqmQPUHTZbSY4WAGdbx2sPcUiAHnvD/KMu7EHCVqOc
	 DcgKzxXaF6wW+Sak4sumWM0QHzmjH68RRH0B2fKBCcrK+w/WaUtP1g7iOvivmpiZTZ
	 RDI7FDdcpHhfzk2O+UOtinq/ZjWfZBg7Zpc5fZIndxs40AXjUynHVB7VRE+Ni3dcKR
	 X80KT7dghwLFsXh+NdChqHmgoP+mZvhBuqTSpkzV/JeIxt9FKWORYbnY/R78/5ZDES
	 Ds7ZhND5XuBVHqRvV2s/ntqJ7nNuM4nZ1NO2m1P1wOcouy2gTXkgHPJ857ZAobfax6
	 Than7fvDqRQ6Q==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Accept symbolic map creation flags
Date: Mon,  7 Sep 2026 13:14:24 +0800
Message-ID: <178875781913.42294.17811476816505465442.01-flags-synopsis@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0846fe9c15dc189bd3cd979839ddd7101f79979217dda130d0800b047589f9fe@mail.kernel.org>
References: <178874713816.1519295.12130500880299787860.flags-v3-1@tychen.cc> <0846fe9c15dc189bd3cd979839ddd7101f79979217dda130d0800b047589f9fe@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Thanks, agreed: the synopsis should have the same FLAGS production as
map help. I have added the line below locally and checked the generated
man page and the bpftool synchronization test.

This is the complete correction; I will fold it into the next full
revision rather than repost the series just for this documentation line.

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 375321d5582..5a5c26f789c 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -48,6 +48,7 @@ MAP COMMANDS
 | *DATA* := { [**hex**] *BYTES* }
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
 | *VALUE* := { *DATA* | *MAP* | *PROG* }
+| *FLAGS* := { integer | **BPF_F_NAME[,BPF_F_NAME...]** }
 | *UPDATE_FLAGS* := { **any** | **exist** | **noexist** }
 | *TYPE* := { **hash** | **array** | **prog_array** | **perf_event_array** | **percpu_hash**
 |     | **percpu_array** | **stack_trace** | **cgroup_array** | **lru_hash**
