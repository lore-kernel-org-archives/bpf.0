Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119991;
	b=Y5H2sBQAzBdn/m/sYUbSR5Zb/YJ6xnEqbWaHrhGQLGAhf8vDuyt6PdLjz0Sqv6I8eWSA
	 qz2e774j+ouHlpMstkuF8XDHxtMPvk24FZfZRtwN3428gW+bG7KgUo2JZnhi6NX7wyeJw
	 e96qCu+tXXlgVqGQ44ZfwFoKsSEqYfdeGAOkrVvVaK7Y9vdKToSxxjIJeOdtq4bhC39Pa
	 jbenTz1D8dWOiGhS8NSqKlZHdthlw8ey7VIwrvPjxGNkQ/MmkgaS8R7QNbpatjGwBTVvN
	 JtVp7qhWCZNsb+B7jsTCH8Pn7GjaM7wDODEVGuA2Hz7N0f+mhORhLqZ34fRvxm3DH1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=uS1rhhA15FIUzT1xOqyurygKDHDFHNQDPEvhuXtD6bE=;
	b=Nwla7zQmRlU6BgTzQRwyHvdyK5pFtQv1ZK2HoNw9hHNWODESU6a4Ee/dABRC86cxwPYk
	 AxHoWYwM07YJs7zA4b5GgWEmpBsrmdyqOg290YDGpVoDEJVfbnAjRK/RtC7E45dxV5JDQ
	 y+EjPEaCV0u9hGSl54UPYTDrEut+sakyUkVPsWaUN6gKhfZm54rvflXADpVcSPfJPZPZb
	 FIC9jPfJ87ZKBbQqKYvx+EA/ll+9WbWuczGuZRscJIclMJdNfUyUBf+1+a1vaJBJyUZdN
	 qpk4zsCpdSN9O5IcaiDxc1zc+pKpBPTYVjWsDwIHU4fn2wHRiUT8ZD9/q2WJMj3MK1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="G1b4a/8I";
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B72606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B72606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G1b4a/8I
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so19655a12.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119990; x=1793724790; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uS1rhhA15FIUzT1xOqyurygKDHDFHNQDPEvhuXtD6bE=;
        b=G1b4a/8Ice6aO5Xm8ZoPJ+ACXTSF6stV3W8qllQBZgHH/HuvihATGiTbhzqLiqbegE
         stHZzLgQakde+bvOhivPNyTPuoN6NX8Qmn/wjxHY2UKottpxwS3+l1gxWqUhUo1Oi4yG
         HX5wojSL9/Pah+6IPfaDqYp2AXrYttfDYGuIXwoeUkY/6CiGpHLMDNtOvWMKvrfjIpPM
         /UU99rwSEKxJ866cObNlBv+xrWJg1V9D/NwKPyHIJeKI/Ly/OEQjlgGyQvUCzrZJhKLT
         Q8+cqe3sukA2BgL3urLqgAYyraDTph8kydSWlu/4PNbR4kdKCJxoezNLfbQrod6eMTGB
         n0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119990; x=1793724790;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uS1rhhA15FIUzT1xOqyurygKDHDFHNQDPEvhuXtD6bE=;
        b=10TrXb/vJBB4qw4jb8F0Bh30MIx75KxjrhF7eMJ6X21g6wAgCXaTko6RqmfysDSRcf
         1qKp7k1iD0WPw3Z95Nyz+HWGNfCvV7T6xktexDfFDNvFHyjInZVzrWjNrDVS+hoR2/wD
         8WRqqc7rjq1rP1cuNb+Na7+OCAUWrKAHRLjcHOwg24zUP7tbg+cWJl1BxojRb8NWlkfM
         felaL5PDSXPJdxqqNze/jr859fcMUl91zXCK4wrwDPt+2IFoSt4mcfU1M1EYpg2Gy5w9
         n0/tTK0b3afnCxWwOPy0FMLOaL+L7LBWhSpAlCp1cuw+5mOZYJy9092SeqnSvVELQCOy
         vAaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWdfp1NPZVGYRhUOcrHzks2wu5wL93hrV5JxQdPJpPsqXzj8lzYtytzNOQmeZe6iA4gVg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ4UKr1teLTeukGJDXKRs0z/4kgNQwK9NNLu6Mp/k2K0MOhK6c
	R7eF3ZctfsS+BbHZOAqS89RAxz8AwicTytmcIvmNA3J5daBvQAUM69Fnm+vV3g==
X-Gm-Gg: AYBFou1/RNlHiNRAHQMdoWANHgYM1x1bY7bs/NK/fORgiW5MHblasIBaH7q6fnu/1yp
	McwwRnZ80bk0nUSKVpre2qCGIQMy8tWH3oTVux8v02FbW+zlkXdSmm3ZoU8KsENnNPaVoPVvZqu
	VGUn7gdG6MFEJJ4rci4yp7PNPR2KNhqjvWbcVCK20dk0vJpaBpaUfzFAZAozyOxCn+6WXjDhfTA
	ZRLOYmhtyv1uSzU7DD31dOdzMfh7I7HGhkrj/QNNYszfSD6eWUx/jf1oxT0BLai4HLVAhbNuV69
	bM7JF56pHcK/ed4utH+TA1zxSwBBoEi2sMWMKqwskapL/IlKVMq7AAU6bRaGEpVDhjI1/yYTV6o
	CCZgwUQ1DB63LbBeNRWfgMo8XwcybpeEw1XvOHemVvykg13M/vbrYYuQ5QdIfxbDHL3N91KIgo0
	EF99ByehsXDX+HCkIZPyBQav8GN9Y9cQRtEFbQx53XS9ZflWDItfw60lOZ3U73JzJtww+Cffxfz
	RsozKkYCWtG9ZyWuEhmx91Ryg/HSORGB0jWnh5zT7U5Eg60tMZRRXQFt6zp8HGLG96mJPRAL8p5
	D/yA/s27inD/Gkk4PbTQRscBvOnsEtL0nEFegbipFahomDpikIskLopv95M9
X-Received: by 2002:a17:90b:33c7:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3ae403c64f1mr1543079a91.39.1793119989888;
        Tue, 27 Oct 2026 09:53:09 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d63b7csm30255a91.3.2026.10.27.09.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:53:09 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 16:53:08 +0000
Message-Id: <DMFRZIXSG0M2.YYE6X1OWNQWL@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 0/7] bpf: Inline IRQ enter/exit instructions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261027162820.10887-1-emil@etsalapatis.com>
References: <20261027162820.10887-1-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 27, 2026 at 09:28 AM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> Add inlining for those functions. The inlining happens in two stages.
> First replace the call itself with a special BPF instruction denoting
> an IRQ disable-and save, or restore-and-enable. Those instructions
> are translated by the architecture-specific JIT into the corresponding
> operation.

No. That doesn't scale. We cannot add new insns for every to-be-inlined kfunc.
See bpf_jit_inlines_helper_call().

Like:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d..c1c9a1c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3495,6 +3495,17 @@ populate_extable:
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (src_reg == BPF_PSEUDO_KFUNC_CALL && bpf_jit_inlines_kfunc_call(func)) {
+				if (func == (u8 *)bpf_local_irq_save) {
+					/* pushfq; pop [rdi]; cli */
+					EMIT4(0x9C, 0x8F, 0x07, 0xFA);
+				} else {
+					/* test dword ptr [rdi], X86_EFLAGS_IF; je 1f; sti; 1: */
+					EMIT2_off32(0xF7, 0x07, X86_EFLAGS_IF);
+					EMIT3(X86_JE, 1, 0xFB);
+				}
+				break;
+			}
 			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
 				if (!fm)
@@ -5116,6 +5127,14 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }

+bool bpf_jit_inlines_kfunc_call(void *func)
+{
+	if (!IS_ENABLED(CONFIG_BPF_SYSCALL) || IS_ENABLED(CONFIG_TRACE_IRQFLAGS) ||
+	    cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+	return func == bpf_local_irq_save || func == bpf_local_irq_restore;
+}

...

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1..26b6a9d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5197,8 +5197,8 @@ BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_local_irq_save)
-BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_local_irq_save, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_local_irq_restore, KF_FASTCALL)

and corresponding bits in bpf_get_call_summary()...

but before doing any of that there gotta be performance numbers that it's worth doing.

pw-bot: cr
