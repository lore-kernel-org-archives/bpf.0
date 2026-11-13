Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546611;
	b=0Odh1krLH6zWrgo2yEY5vIipXsA+2KB5irTG/jXqEWaQwkdHUHvlbjxsIQh1kFkOgNM/
	 9jVY6L+mELHq0ZjsVBlu6MKB4HHa4kFHrWlSFl0z95Z1M6pKibftU9Eqv9uQI+RuN192d
	 /0PsefS8MiZ+CazKwAjVtLgyjiNwxFc5NlakoaD4IDr5ufAYuHYg8xE8ZJMV3sJLZr1w7
	 nZ3rZu1PFIG0xI/lRqE3nXNDSRGFxa4edvxbNZ/0WF8NGXKApz+LftJvFS9niey70SZl/
	 ZxQqtiC2/iMr5ZcPGUS61n38D12/nompMWKcXnvopnKORZllWRyXfJKAXugsPAGvWRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mpWG1ec+W12RkTlN/dD1mf2HagJyd3Bh3JJ4ZrIy9Ms=;
	b=o6N8bjHG/BG7T0a0h0p7pEGyWUQP+iZ0B/BGPNP9jQrY5Y1fFmJUlBiiaKwc9M7b9cNj
	 LOhSeJ1ZZzEmkQ8uoI+etq2hEjU7nSR+HfVvVp9fjWYa/BT623c/O5GMAOClKeaC/1EcB
	 P52v2g2cJQuQIRHKVbAU3BlV2tYW+b9IglzcyuT7iZzfCi4FGu6W3hMaljcZXz3B53Gz6
	 CLXZ3S8CIxN+B4OKbvsyutwqY5wHqH9jDh0WB0hhfiymHrX8OUHL9vRBOkn7qMkUAmUB8
	 lMgcmF4l/ay9OY//RZ6q+seYf60OAoeaO8zUn9qpaBLp+pNgFHezzG/ZkvZY3M+kfkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKjS1qqY;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3E606A31C
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBB3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xKjS1qqY
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so284948a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546610; x=1795151410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpWG1ec+W12RkTlN/dD1mf2HagJyd3Bh3JJ4ZrIy9Ms=;
        b=xKjS1qqYM3T/ZPGGS4+LiVTNFqSs5jSKyBWVoPrAVnUJI+QqHWyhfAxbqrZuf+3Ykj
         gxdk+HgvREEsvL2EF+DCNypGx5EaT8o/8igj39sKONeva9AsiL5ecY3NOIEoin+Gt+84
         fLJrWyfFxNYP1tAMs7glyHGXS1qbcwbaOGQp814JEUHazyw40HcE8/t5mDyr0JOLWg+Y
         NKaRiwhHcOgX9LeZs3ewutV9aJjsYZnlW1c1b5QVtWd1msGsHk+Js4QXAlTRTyiki07V
         Wl/4CTm1Xpr4eorBCoKeatuxxJcOqZ5ZnftxBx2CAyNo/tR0933vFVWiSxEE3Wo3Lh/3
         UerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546610; x=1795151410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mpWG1ec+W12RkTlN/dD1mf2HagJyd3Bh3JJ4ZrIy9Ms=;
        b=lsytPKDXf6wCWGznsYKxs8XfKs3oWYbBO6MOtvhQ5dvRnK4nMK9oeLRtBl/TYWV5De
         e6ODSfljULNQWQW1BQdmxm2lEP0vyQFu7NhTn+tDxLYYaAo9T2aC1m6swUH6suYjRI5K
         OKY+WUnWZrGdGJDEKQuoXDwaO/GABEF6SHjZmrK/XhpAHGevVJMrB9jQOtM2l5fnA1Qr
         77hTKpR5FsXboY2FS9pdg6qItvXEGLC3PF59INqpRO9Zh4n55htTgcWVcPG7yx02uK5J
         vCO+CJ/36UbGCW2tKPcXtlDxfWuy9jCV+Qx4/4dUn7eCtiiFuTYBxAKQD2FrKIS0yJ4u
         F73Q==
X-Gm-Message-State: APuU4Z8QyTW7sA8gDgWKUhBPm/2atW+WEFv3Iaf2chXYNGLu3FRUusSu
	0uddMUX5kPdc9nGAfgo5W63ENlUeUScAJZvTMkj0j1Frw9nwCjXjSzeXX57fAA==
X-Gm-Gg: AYBFou0dMCY9OYw60xp/Iwe4IlE65/lzaT00SE3zCSUqfK9Gqw8SvHMHZQ543ngPLx4
	23C7ngh78qSHK1HBjmk3g1lkBo6iF8sRDO8QX7SGPjh+FyPwbUoiPYdOVzkZVCw9In/PmQD3zky
	hYoGTiEoKbToJSQxKOsnoFEBPVJfqmb5J2LbD1B4svFHx3reCwLwFDKQOF7ynDKTrQHKHquM80J
	9auwvUuyfX/KyOdUsAKT6kZe5RfYunlkx+feoaVQ9UkHxYh/iX2KPI5LHQq0D53ayyDUVzkSZ31
	aFn2zCrqHx9V8wCaPVrYwK0I8ov8JD+CALESClrn+NI9VYLC/8Vu9zJUIGgU0xQ9pjOXNfoYiPt
	O/CoXxTtsCqNhKhev8/wnt3A3cfkU/buuptOLHrImIuv0X74wZVOtsgb0lAzxhOFEKRG73nTkiq
	d8xv1wpzH2rzAGurJJcEPMPZQieQY6O3CxuoO6ijFsTvixEU9g4+szX4HvMWDUOi2ApIUOhTHfS
	mQGcfgn6eu+AS3yzk3y52xyO+mwmwiBJuvePY1lR97Ik3Nk/ZO5lMQv+7EQ9wPggyqp61w/EaUr
	b5/bdyYhoPoEPmCADkTZyHKrsMXrObMdYFrws4Inu+908yMWkksQ3y68xHLhKg0NQJqo9F6dnS/
	+m+L5+RYTvvmWNzjtVuk7QEwmgUTVDRJnPE2G7ogQKhXtOHl/K3rQSh5YM2VZf9kbK8wlYoi4fw
	==
X-Received: by 2002:a17:90b:5610:b0:3b0:a757:e370 with SMTP id 98e67ed59e1d1-3b1b0d9c507mr744609a91.42.1794546609592;
        Thu, 12 Nov 2026 21:10:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb17853sm2492101a91.5.2026.11.12.21.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:10:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 11/13] bpf: Mark the arguments of fmod_ret progs as PTR_UNTRUSTED
Date: Fri, 13 Nov 2026 05:08:59 +0000
Message-ID: <20261113050901.1399091-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

fmod_ret attaches to about 12000 kernel functions now. Nobody looked at
what these functions get. A pointer argument can be NULL, an ERR_PTR(),
stale, or an object that is not set up yet.

	SEC("fmod_ret/tcp_v4_connect")
	int BPF_PROG(guard, struct sock *sk, struct sockaddr_unsized *addr,
		     int addr_len, int ret)
	{
		if (bpf_get_socket_cookie(sk) == cookie)

sk is PTR_TO_BTF_ID without a flag. The verifier does not rely on such
a pointer: each load through it is BPF_PROBE_MEM, stores are refused,
kfuncs want a trusted pointer. But helpers take it, for compatibility, and
dereference it.

PTR_UNTRUSTED is the flag of a pointer that nobody vouches for. Such
a pointer can do what PTR_TO_BTF_ID without a flag can, except that
helpers refuse it:

  R1 type=untrusted_ptr_ expected=sock_common, sock, tcp_sock, ..

What is loaded through an untrusted pointer is untrusted too, also a __user
or a __percpu member.

That holds for each fmod_ret prog, also on a target that is allowed today:
security_*(), a syscall, the error injection list. A prog there does not
load any more if a helper that expects a kernel object gets an argument:

	SEC("fmod_ret/security_file_open")
		bpf_d_path(&file->f_path, buf, sizeof(buf));

bpf_probe_read_kernel() takes each address, as before. All fmod_ret progs
of the selftests, Tetragon, runtime-enforcer and bad-bpf load as before.

The arguments of fentry and fexit progs keep their type for now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 228b93d4f8c9..4ed660dc4612 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7618,6 +7618,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	info->reg_type = PTR_TO_BTF_ID;
 	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
+	else if (prog->expected_attach_type == BPF_MODIFY_RETURN)
+		info->reg_type |= PTR_UNTRUSTED;
 
 	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
 		info->reg_type |= PTR_MAYBE_NULL;
-- 
2.55.0

