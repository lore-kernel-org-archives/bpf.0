Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259310;
	b=RYSIiWMH9LeiAU3EDIrNT/1sHTZw/C8MUawoAALNqOvtM9IYrv5OCGR7Xk9U2ZDVF7Ll
	 etlJ6qky9M/buAes1mnHA2RFIU5fwOEcBpPsoylI4SwH8mBoUGIcs1Ns4+0DvkxrBRJBt
	 CzjMfVTgO/iccv1v2xNjHb8fgQyPQxhCqa5IACY0RfjWiV3l9K7v4HmmzAmdHp0BSw1mU
	 RT56kNgNH6e7en3a0udZk20JcugUQzXmvz331Av09Tx/MgB1u3T892/fKKTkZsTaHT02M
	 wwncWpcsStxDcHvFjUcsLrkQoEVacim7FWO7wFddVH9ScwGvJHs4h8nYzniiQ2PwFTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259310;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=sRoXQOLMcZAIEFXJdx6jUj5MNy5hDFeGder7q1cCC+k=;
	b=krsrS2Zr9EU+lZw/qpyQsZTFJcbrN2bUhBPjbgw9LjK+EIpR6LSdbpbdMfpfQEcFuDmH
	 nVQqnr7mpNbNJTIFpEp6f0+CviZ9NgZ4xSB5qk+qFO5DdIbhZYE/NNQ0BlL4t8k2gp6og
	 gIYSwdy1c28hOqf3zVAp/2241Wq3WZ3xD+jyoKHtHwmnvIXFf/lTlmmngkEDR3IFQPaDY
	 Wxvjqd8vHukTJbKWn2qZb0XK8cpL2uSAAmyVPB9U/dJqxIGLNwOqbBrlsaVUPl7v1ru9y
	 knTjHFjKnswZ+HtgLrigHZWBGYI6gVsHqGDqXPM2kyHdXt7gvcRpeY0pRo5j6s0ZxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QR750SsO;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B6606A32A;
	Thu, 29 Oct 2026 07:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 219B6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QR750SsO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sR
	oXQOLMcZAIEFXJdx6jUj5MNy5hDFeGder7q1cCC+k=; b=QR750SsOf1DZIgPHzd
	/TDXBV8N6t7pbIn2YAJRhOgICMYTjR4trMl/Khm8/1/EHeiAWqyGU9BZGbMdkT0S
	rZeZbf3Ap9OXFMMKd7hfRHiYFEucAAsFwMdoXU/Q1J4YINzOKw3/NFXyKEcQLpq0
	wQRT2JID+Ub4g8UKEYM0jhVSs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBXMJHY9uJqilfyCg--.26815S2;
	Thu, 29 Oct 2026 15:33:46 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: yangsongsen@insta360.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	matt@bobrowski.net,
	memxor@gmail.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()
Date: Thu, 29 Oct 2026 15:33:44 +0800
Message-Id: <20261029073344.729148-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261028125148.1348-1-yangsongsen@insta360.com>
References: <20261028125148.1348-1-yangsongsen@insta360.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBXMJHY9uJqilfyCg--.26815S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy3try7XFy7WFyfAF17Awb_yoWftwb_ur
	WqvFn7GasYqrWvyan3Gw13Xr9xK3yYqr1xGFW0q3sIvry3Ja4kZayvv3s3X3y3Xw48tryv
	vFZxWw1jgFyS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_uyxtUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzxtHv2ri9ttuLQAA3K

On Wed, 28 Oct 2026 20:51:47 +0800, Songsen Yang wrote:
> Hi Feng,
> 
> I hit the same root cause independently via syzbot and sent a fix a
> few hours after yours, without having seen this patch -- sorry for the
> overlap:
>
>  https://lore.kernel.org/bpf/20261028121859.994-1-yangsongsen@insta360.com/

Hi Songsen,

Please don't worry about the overlap.

I hadn't noticed the issue Sashiko raised when I prepared my fix; 
It looks like a pt_regs on the stack can fix this.:

	BPF_CALL_4(bpf_get_stack_raw_tp_sleepable, struct bpf_raw_tracepoint_args *, args,
		   void *, buf, u32, size, u64, flags)
	{
		struct pt_regs regs;

		perf_fetch_caller_regs(&regs);
		return bpf_get_stack_sleepable((unsigned long) &regs, (unsigned long) buf,
					       (unsigned long) size, flags, 0);
	}

That said, I think your approach is the simpler one and the better fit
for the fix itself.  So if the maintainers prefer your version, feel
free to ignore my patch.

Thanks,
Feng

