Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E771474CC;
	Thu, 16 Apr 2026 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350215; cv=none; b=Tu9N7DfrCZkIeYqto0ZQFAkXQGJdo0ishCI6EDtPPPXjaePNmFEmx+a9hlqXYlI1vN4uXtLCP9eRNTJZtPGi9eZZUAvsCxxNnxcYJ82B4N1jxYzvaRgdxaxJsq8SsF+aTcxiT5g5T/ggqsio67V9cI8Qde7ECAoJ1bsPGGhMxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350215; c=relaxed/simple;
	bh=QgoN5kSxFOqTuErwTWA3I0G39yVNoEam3eTHPfOVC5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKV5+I44dJZiEChIx3kEWYUf39/5K2Dz0R6kpAGhpTDKoUvTZe5O+MesUAU6O8eHWL26Uk6XwHOhYnwRVXdmsXL2+FboNfDXhT6rGWv3sXHZ+yjg2uS/N2qUzPw54Uf6uF0ng+UA0/ouT+kZfSaBltXzbxcwZVYGbmfIqLm4m98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=U1H+Ib+X; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="U1H+Ib+X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=R62AUm4dbR2g7jh3km5ZWiRaBBEx+9bq+u2DsGt2Np8=; b=U1H+Ib+XJjruPwuhm8mipFuXPO
	STqPn66pjzY0lNsLbYPAZy0kcKqJx2cRT/7CqH5jkLXq92EZc9gBdUTrUOhMRM7o3KDb3p2Ca78oq
	mnk5wZiGlVQTtwtssXTgRT2Rjyi35/cBTZ/bnx1du3i9np66GO/B0MbpLI/l6JYWZ6jDxHBI0gcr0
	Go1eeCg54ugA1GkE163nnPQV/VglEcqL6MHbHbJWUAG9fFMJZ0SrvQM83Msw70Kh43QnSK5YhbbKG
	uE+DO7ND5JrhxJfZo9T58kNSAmz+Ft2idZRkJwEYEsAZhUFJCTwU9LpMWgTzXK4jxfifpFCgwM+wS
	KKfv8ggg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wDNpp-0008Rg-22;
	Thu, 16 Apr 2026 16:36:49 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wDNpp-0008GB-10;
	Thu, 16 Apr 2026 16:36:49 +0200
Message-ID: <96a56535-6016-402e-ad25-237427c2caaf@iogearbox.net>
Date: Thu, 16 Apr 2026 16:36:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: XDP BPF JIT memory leak on armv7
To: Jonas Rebmann <jre@pengutronix.de>, Alexei Starovoitov <ast@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27973/Thu Apr 16 08:24:10 2026)

Hi Jonas,

On 4/16/26 4:05 PM, Jonas Rebmann wrote:
> Hello,
> 
> We have observed a memory leak when using the JIT on armv7 with XDP
> programs in all kernels tested (6.1 to v7.0/master).
> 
> kmemleak reports:
> 
> unreferenced object 0xbf0a1000 (size 4096):
>    comm "ping", pid 818, jiffies 4294949376
>    hex dump (first 32 bytes):
>      00 10 00 00 f1 de fd e7 f1 de fd e7 f1 de fd e7  ................
>      f1 de fd e7 f1 de fd e7 f1 de fd e7 f1 de fd e7  ................
>    backtrace (crc 38a5ba95):
>      kmemleak_vmalloc+0x38/0x94
>      __vmalloc_node_range_noprof+0x624/0x7e0
>      execmem_alloc+0x7c/0x100
>      bpf_jit_binary_alloc+0x64/0xfc
>      bpf_int_jit_compile+0x14c/0x348
>      bpf_jit_subprogs+0x4fc/0xa60
>      bpf_check+0x1840/0x30e0
>      bpf_prog_load+0x720/0xec4
>      __sys_bpf+0x4cc/0x25d4
>      ret_fast_syscall+0x0/0x54
> 
> This was reproduced on various debian systems:
>   - stock debian sid with 6.19.12+deb14-armmp-lpae
>   - stock debian 12 with 6.1.0-44-armmp-lpae
> 
> As well as debian sid with custom built kernels with a
> multi_v7_defconfig based config, amongst versions tested: latest master,
> (7.0.0-08391-g1d51b370a0f8), v7.0, v6.18, v6.8, v6.12.
> 
> Precise reproduction steps:
> Enable the BPF JIT (if not done via CONFIG_BPF_JIT_ALWAYS_ON=y):
> # sysctl -w net.core.bpf_jit_enable=1
> 
> Prepare any simple XDP program:
> $ git clone https://github.com/xdp-project/xdp-tutorial.git
> $ cd xdp-tutorial
> # apt install git cmake build-essential xdp-tools clang pkg-config libelf-dev m4 libpcap-dev llvm libbpf-dev libxdp-dev
> $ ln -s /usr/include/arm-linux-gnueabihf/gnu/stubs-hard.h /usr/include/arm-linux-gnueabihf/gnu/stubs-soft.h
> $ ./configure
> $ cd basic01-xdp-pass
> $ make
> 
> Store /proc/vmallocinfo:
> # cat /proc/vmallocinfo > /tmp/vmallocinfo-before
> 
> Load the program and confirm it is loaded, unload and confirm:
> # ./xdp_pass_user -d lo
> # xdp-loader status
> lo                     xdp_prog_simple   skb      83   d4f8542f2b42fac5
> # ./xdp_pass_user -d lo --unload-all
> # xdp-loader status
> lo                     <No XDP program loaded!>
> 
> Compare /proc/vmallocinfo:
> # cat /proc/vmallocinfo > /tmp/vmallocinfo-after
> # diff -u <(grep bpf_jit_binary_alloc /tmp/vmallocinfo-before) <(grep bpf_jit_binary_alloc /tmp/vmallocinfo-after)
> +0x4e292a08-0xae3e49c0    8192 bpf_jit_binary_alloc+0x64/0xfc pages=1 vmalloc
> 
> # echo scan > /sys/kernel/debug/kmemleak
> # cat /sys/kernel/debug/kmemleak
> [see above]
> 
> The backtrace corresponds in commit 1d51b370a0f8 to
> 
> mm/kmemleak.c:596
> mm/vmalloc.c:4093
> mm/execmem.c:44
> kernel/bpf/core.c:1093
> arch/arm/net/bpf_jit_32.c:2241
> kernel/bpf/fixups.c:1122
> kernel/bpf/verifier.c:20099
> kernel/bpf/syscall.c:3083
> kernel/bpf/syscall.c:6252
> arch/arm/kernel/entry-common.S:44
> 
> Each subsequent run introduces an additional leak.
I don't have access to arm32, but it looks like its completely missing the
ability to do BPF to BPF calls.. you would need something like the below
(uncompiled / untested).

It would actually be nice to you have any chance to run through the BPF
selftests to see what else is broken on arm32. Outside of x86-64, arm64,
riscv64 and s390x BPF JITs the results might vary quite a lot on what works
and what doesn't. :/

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index deeb8f292454..89b24fe357aa 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -216,6 +216,12 @@ struct jit_ctx {
  #endif
  };
  
+struct arm_jit_data {
+	struct jit_ctx ctx;
+	struct bpf_binary_header *header;
+	u8 *image_ptr;
+};
+
  /*
   * Wrappers which handle both OABI and EABI and assures Thumb2 interworking
   * (where the assembly routines like __aeabi_uidiv could cause problems).
@@ -2146,7 +2152,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
  {
  	struct bpf_prog *tmp, *orig_prog = prog;
  	struct bpf_binary_header *header;
+	struct arm_jit_data *jit_data;
  	bool tmp_blinded = false;
+	bool extra_pass = false;
  	struct jit_ctx ctx;
  	unsigned int tmp_idx;
  	unsigned int image_size;
@@ -2171,6 +2179,24 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
  		prog = tmp;
  	}
  
+	jit_data = prog->aux->jit_data;
+	if (!jit_data) {
+		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
+		if (!jit_data) {
+			prog = orig_prog;
+			goto out;
+		}
+		prog->aux->jit_data = jit_data;
+	}
+	if (jit_data->ctx.offsets) {
+		ctx = jit_data->ctx;
+		image_ptr = jit_data->image_ptr;
+		header = jit_data->header;
+		extra_pass = true;
+		image_size = sizeof(u32) * ctx.idx;
+		goto skip_init_ctx;
+	}
+
  	memset(&ctx, 0, sizeof(ctx));
  	ctx.prog = prog;
  	ctx.cpu_architecture = cpu_architecture();
@@ -2181,7 +2207,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
  	ctx.offsets = kcalloc(prog->len, sizeof(int), GFP_KERNEL);
  	if (ctx.offsets == NULL) {
  		prog = orig_prog;
-		goto out;
+		goto out_off;
  	}
  
  	/* 1) fake pass to find in the length of the JITed code,
@@ -2243,6 +2269,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
  		goto out_imms;
  	}
  
+skip_init_ctx:
  	/* 2.) Actual pass to generate final JIT code */
  	ctx.target = (u32 *) image_ptr;
  	ctx.idx = 0;
@@ -2271,13 +2298,21 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
  	prog->jited = 1;
  	prog->jited_len = image_size;
  
+	if (!prog->is_func || extra_pass) {
  out_imms:
  #if __LINUX_ARM_ARCH__ < 7
-	if (ctx.imm_count)
-		kfree(ctx.imms);
+		if (ctx.imm_count)
+			kfree(ctx.imms);
  #endif
  out_off:
-	kfree(ctx.offsets);
+		kfree(ctx.offsets);
+		kfree(jit_data);
+		prog->aux->jit_data = NULL;
+	} else {
+		jit_data->ctx = ctx;
+		jit_data->image_ptr = image_ptr;
+		jit_data->header = header;
+	}
  out:
  	if (tmp_blinded)
  		bpf_jit_prog_release_other(prog, prog == orig_prog ?
-- 
2.43.0


