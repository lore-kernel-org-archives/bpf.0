Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459043BAD95
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396059; cv=none; b=f7FCFcSxGia8wAgOBdQ5cNw/waYfkgMJqNa2OIfEG0q4grRTPifzPnRMrGpe+zFd1m4I5uhwp/CROdNDKAcT1mcDl4suZTx7ewN0ZgOmMRJAs4zlPM9pFmxPWi1Q6r0UFpiyOxY55A7/45x35Jxv8UYswufW96R9U3DtfewV7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396059; c=relaxed/simple;
	bh=3Ly1KSQ9fA1bmOOlJGAt36L/P34Btkes07L3PU4rbG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4G5rBMofW4kavGWWDsAipojoqieUOFse5jJ2e1OQ6f64pXE/I8qCa1JTt5W3hlcuChm6TriZxEJi31wFWk2WAnDrKUgQg7m09lXKcb0kbWTCpuU58nckmh0SSeeg141e5tm+Cr0V38WCPNWo6kQLEwHMT7va1AX4/vo866VVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qbH+sIT8; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qbH+sIT8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785396041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ly1KSQ9fA1bmOOlJGAt36L/P34Btkes07L3PU4rbG0=;
	b=qbH+sIT8ihnliNU/GNo5sA2dE0ls6RRX+aHv7fVRXKLs9eWjrQXU3ykTbccJ1Dzk5nIQGc
	S+xfTcTGNoMsibJhHirewQp3gSirxNL9X7RRFBZs9EEVGY46sKXJlfXKq/6E0mdbPhzu45
	QYOFwOo2ZRzgMkmF2KoMo9r7Gz2JTSg=
From: Leon Hwang <leon.hwang@linux.dev>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: Leon Hwang <leon.hwang@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf v3] bpf: Fix potential UAF when reading bpf link info
Date: Thu, 30 Jul 2026 15:19:54 +0800
Message-ID: <20260730072009.403954-1-leon.hwang@linux.dev>
In-Reply-To: <20260728025457.2814876-1-pulehui@huaweicloud.com>
References: <20260728025457.2814876-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, 28 Jul 2026 02:54:57 +0000, Pu Lehui <pulehui@huaweicloud.com> wrot=
e:=0D
> From: Pu Lehui <pulehui@huawei.com>=0D
>=0D
> In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is=0D
> accessed without holding any locks. If the prog is concurrently replaced=
=0D
> via bpf_link_update, the old prog can be freed, leading to a potential=0D
> UAF issue.=0D
>=0D
> Fix this by accessing link->prog under RCU protection to safely fetch=0D
> the pointer and guarantee its lifetime while reading its fields.=0D
>=0D
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active b=
pf_cgroup_link")=0D
> Reported-by: Sashiko <sashiko-bot@kernel.org>=0D
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>=0D
> Reviewed-by: Amery Hung <ameryhung@gmail.com>=0D
> Signed-off-by: Pu Lehui <pulehui@huawei.com>=0D
=0D
Acked-by: Leon Hwang <leon.hwang@linux.dev>=0D
=0D
> [...]=0D
