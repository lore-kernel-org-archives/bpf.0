Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3D9485CE8;
	Fri, 11 Sep 2026 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135086; cv=none; b=PNFqHwNwhP/uFVnaZX00SYSY9iReIpvgUD5NZDVXk1XMJgylor4VNuh3D/wmHfrfEzeLWkYiOPVsjcb545MxXj2I1D1bjSIdPbELHtQNDgrL5k7jQ6m/6g4Zt6YbnT077R5cL1qyQkH797VhPjSMqJBajE7GiUbH7RZx/lSIlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135086; c=relaxed/simple;
	bh=wJeij60oOKpNAnRDMfXszty2GOYldDyvj+f613w69+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZz67OLYuSUv7ocsVenq9QAfxKFBcpfgQ+UHeTHv6e7Gys4YiEfV9RpwAwcdO4Ed+Vrsk+Sseijn02+7gKa9j+Lsb5k3/5VBRxF5i3ID8Cc3jhR4y7LH+nN3jRyOBvHR6C9z6wQ2d/21c7VIInLKpN2pwKhEFJ8DnfyXvtHJUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rO4YU8Qn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rO4YU8Qn"
Received: from localhost.localdomain (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 16DB020B7166;
	Fri, 11 Sep 2026 06:57:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16DB020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789135037;
	bh=wJeij60oOKpNAnRDMfXszty2GOYldDyvj+f613w69+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rO4YU8QnPnHhY4Ja2wRNcWXlzDdF1STZ22/YLOMt3J1wZF5RBV+oJzvCLDe/qKl1K
	 s4rEBjInFCm2WPn5p1FMnJiDJxnYR6rW0dndni7mnTYYZRyLBmf0Mi6fDnJ0YibzHO
	 PFJkJaGLnBN9ZROdqslN2RdnuuF0E+6WxLh5yJCU=
From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>
To: xuanqiang.luo@linux.dev
Cc: AutonomousCodeSecurity@microsoft.com,
	ameryhung@gmail.com,
	ast@kernel.org,
	bestswngs@gmail.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kees@kernel.org,
	kuba@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	mattbobrowski@google.com,
	menglong8.dong@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	wangfushuai@baidu.com,
	xmei5@asu.edu
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
Date: Fri, 11 Sep 2026 09:57:36 -0400
Message-ID: <20260911135736.80463-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c3f2a61d-d5bc-454c-987d-717b5f8c8809@linux.dev>
References: <c3f2a61d-d5bc-454c-987d-717b5f8c8809@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Amery and Xuanqiang,

Sorry for the delayed response. I somehow missed this thread.

For clarity, I am using my new Microsoft-approved email address,
cenzhang@linux.microsoft.com, for this reply and v2.

Thanks for all the reviews. I'll send v2 shortly with SEQ_SKIP as the
return value and the suggested Fixes tag.

Thanks,
Cen
