Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409862;
	b=g6nOIpQIWHrPh62nAgh7jQW7FBvnEvetqKc3+NOj/qvG3mHTG6TKYzEyOm6HFHVikUpm
	 G1RvPQc8+rLE4GQxtWa1+EUvSRrAO18eXQF4xr80Yr5/TLZRfheA5W29FB29mh9ruirH4
	 IdcfXQkzk+lhgcfCZYgHhr2OCwTUgRJmc3nzrifJT8j33VSGVR9uGOdC3dKGICjeIcgP6
	 k0KWq/zXuKWrJ7znMtDFp2cpHBZSPu7weYF/TGnkE2iqWKZazCgBUkWpRAEpgYpI1ChSU
	 qtcXkrSEcDq6McN1lj5qeEdAe9CUSENC0DoWJ1657qel1N5ryi/+43I3w6MhyO/6Mbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=d2RCGmDzrb5brbldUzpcvvEwJ92ts5K49mJH6OL4I80=;
	b=v20k623y26LRHedRZ7M7c9G1F40CkyR/dhFKZlO9nRfw1o2WXgYhLbrh4x8vAsM0OAWJ
	 FSay2OIrcNbq6+xQtMvZZLzC7WLZf5cmaUpXeemWZlk3CLIsGx5CiTBAPfEsHVu9eJt/n
	 ocfZUPwYLjVD92k0LgU/cj7QswlEzGnEpoWHDRDXzAk5wE2fmaLtbOiK2Ej9uu98922Iz
	 MZLaxF4GOLNYyOGjU0MwLYV53qmE5+sXH64su0dBh6BEyD+aarZ/gmy3F6u854e6TpWcC
	 XFlYQbF5zq8TtnfOGJeH6AwSMkHHjfQGnAtBu5gAE/dBy3FAkKQa19ZFrtpdy/OTTxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Dpl/krmu";
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104C606A32A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C104C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dpl/krmu
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b647bbf87aso2309196b3a.2
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 20:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409861; x=1796014661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d2RCGmDzrb5brbldUzpcvvEwJ92ts5K49mJH6OL4I80=;
        b=Dpl/krmumFWDZ8weJNtsc7VFttCu8/mywfOPbRZVNXnUX71YB63uuDbHO74K4ys2fa
         KuIA5+12ye35M9QY1u+YFLtdZzN9Iu3tnMnXeZRgosaytOxo1EfWlf9sGdVLnwn6+WKq
         Od5TaVgOdrxKOcVHPLxwVjRf+2sRTFESFJwlH4WthMcwgjdSdbbHXF21IJCailRQB6a7
         8VNBc+59Rc99Z0pUDUr5tJ6Ialg25li4avNJy9mQCmMPAFjLKdNe0Z+Vq2ZkiP/x3/AL
         0R+tFXzaXIcijylYk2wbQCrBcj8fwKgnwGAVz4wWHCdl1U/obHWLPpGIkSvhBiuGgkiG
         4hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409861; x=1796014661;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d2RCGmDzrb5brbldUzpcvvEwJ92ts5K49mJH6OL4I80=;
        b=J2PpG5/2FtHgc6E5AdGA5+Pfa/uiyYQ9IOCqBYryQ2WMaBNe7m9cL8xRAJwmlkBG7w
         bimpZqfT2sRUYNwqnDn5cBt36ClcVM/s1NbYzEWb1ySeZVizxesgB7oUkVmj1+EL4PGQ
         BXbO9Mx/DKMx26N+lcIXn4fcuqEG2hT5t27mNs1/oQSaaKjMYbKh2B+wzNSv2I1J4TAX
         3W1FYVh0Wpffv2mbrnlWsbSrvtTYIsRLuFxxxHzF+MXQrAp6RDa3GAEwoPcKPj2yYyDs
         +f5e5ynHDeys4GD5Em5OHChyVV8Z0l3Bt4lI+sXzvB+bWifaAcYIKyFKi7SOJXzHxD0k
         q6bA==
X-Forwarded-Encrypted: i=1; AL+hErGqBYNBoUPw84WcRIa1/5qAqRJ4scbUbSKKnP7OPzZ4UwiVvgI9Is3e+kmJVNNfB6j6vCo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wgqtQd6lbffoeebAeTWpZONbFeaGA7QTsq15YRNaih5WnoQH4
	0qrP27t7zjLGr2kMHWV04FOHOCEdacszLAmjYZjV4D42s4zEznnyLSB7RNTDjjc2R1cZ1/U7wlf
	G0w==
X-Received: from pfud19.prod.google.com ([2002:a05:6a00:10d3:b0:88c:e369:e5a4])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c791:b0:3fa:162b:d209
 with SMTP id adf61e73a8af0-4014ae820a3mr9794641637.15.1795409860920; Sun, 22
 Nov 2026 20:57:40 -0800 (PST)
Date: Mon, 23 Nov 2026 15:57:29 +1100
In-Reply-To: <20261123045730.1960346-1-tweek@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123045730.1960346-1-tweek@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123045730.1960346-2-tweek@google.com>
Subject: [PATCH bpf 1/2] libbpf: Skip BPF token preparation when generating loader
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sid Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When obj->gen_loader is set, libbpf emits loader instructions instead of
issuing BPF syscalls on the host. Every other kernel-interaction step in
bpf_object_prepare() (such as bpf_object__probe_loading() and
bpf_object__load_vmlinux_btf()) already short-circuits on obj->gen_loader,
but bpf_object_prepare_token() does not.

As a result, offline loader generation (e.g. bpftool gen skeleton -L)
probes /sys/fs/bpf and honors LIBBPF_BPF_TOKEN_PATH. Worse, if the build
host has a BPF token-delegated bpffs mounted, bpf_object_prepare_token()
sets obj->token_fd, causing bpf_object__create_map() and
bpf_object_load_prog() to set BPF_F_TOKEN_FD in map_flags/prog_flags.
Because gen_loader copies those flags into the loader blob without
serializing any token_fd, the generated loader fails at runtime.

Return early in bpf_object_prepare_token() when obj->gen_loader is set.

Fixes: 6b434b61b4d9 ("libbpf: Wire up BPF token support at BPF object level=
")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fb8a1f07c5b6..388facd11c38 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5212,6 +5212,9 @@ static int bpf_object_prepare_token(struct bpf_object=
 *obj)
 	bool mandatory;
 	enum libbpf_print_level level;
=20
+	if (obj->gen_loader)
+		return 0;
+
 	/* token is explicitly prevented */
 	if (obj->token_path && obj->token_path[0] =3D=3D '\0') {
 		pr_debug("object '%s': token is prevented, skipping...\n", obj->name);
--=20
2.56.1.750.gf70dc682cf-goog

