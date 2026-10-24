Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792813428;
	b=OtptUOUPskjjdiHgBSpMfdtVYbwQ1B4rv14i4ZKo18CxmajWoALsqXatwZCIVPFQqUQd
	 fsEo7p8iNI5g30bSUquQRpYxDnJiGxJpV4YSTF4bXCAoT1XBlWgkgIrcYjYdyKJ9+3PLs
	 jYYgv5TbkBoyDZoN8lYZXp1PyG+T14LE5+Utv3qfmXh5mBhwNkWNRf8G7BwfJQNo1nKCq
	 fTc1lKhbzpoVPOrwtgq3kEtyb13sTm5IATOHXQsjv50cxmhJYHJKvIVWdccrTnJPQJhvW
	 48yUxpIJMFyd+K9FZWBXoRAm+/vahsGAAqLf0aSCg0ZdC5At7vTVsHHK4zDFC/9/yxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792813428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=d5tL+X233SBVjpK2kn/G74H36r+U4Cu/y1SW36/sfhE=;
	b=vQ+4C4t1Lg0SR3dXfF+7xyTirK+aRIA+yjJ2B5w5ZTwF5Onxyqvp0eFQAKLF7z4HuCfd
	 0rOUyjxxdw8dvpF0JizwIQahsvWqiLf/xySuky9Oex0RJKa84qRmGLCnCuq+uBTrLf1RD
	 unZebIqUDz5APdrFkgKwOZlUTe3X/M37k7n1oYSP6KHWEKFd9ku7ZGEqxjzj3oTI4BCKg
	 /ngW5LY2GOue5pXJ3d/qi6/CPdvyYnighkXrFz2b0n2+PU0rg8KywKpW5uNdYz4fFmeWN
	 vh3pyhgpP8jb5SrzK5wEsmVVVIEFkjck2hdQln+OFwDB11wXh6Pcslo+ISbmE4NVElw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFn+R6Je;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D43D606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 03:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D43D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFn+R6Je
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1143939a91.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 20:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792813427; x=1793418227; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d5tL+X233SBVjpK2kn/G74H36r+U4Cu/y1SW36/sfhE=;
        b=QFn+R6JextFEPaRC0BMn5EM/nsFvDDthBDlOomgr6taVDislzkWrrlDQMdLA7OsXgj
         d0y2akaGps4lrDwko20zptIIzs5Wg2lp6gVjsY7nq9wF60GMEuAFm/srcL70SRPuSeYA
         W9hggHShU5J2pbJDFZlLeDEx8lgFb5xQoDA85MeAfh5Zo61hLyMFh0vaiMPtt4EQdyKT
         0umpCIhfxSkzLkIJ5eQY0JTrQga3Yw54iMbY6LRN4UBXPsXwN1+mWtGTtTeT012ROcL1
         pF7epFhQAVPu2OtVcghfxY9Qik4nexWU10Mz7ASV3WTIOSJttv4tmdZi+5cG9YFGy/oB
         2LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792813427; x=1793418227;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5tL+X233SBVjpK2kn/G74H36r+U4Cu/y1SW36/sfhE=;
        b=IbYU0TJx2ZenA0xcKW6vH2fd2Wviej4K4kjJcaDUsJozJr4hWBKbzgopm0zqAjCHSR
         SsipZG6YXA0as7VkTVcoPeWOC09R1ma3yjYpPScytcocoX21Z4zr+itarUikb3RGPhW/
         xYEqPqNSTVYLBH+OdoQyJLi3lG4AtuLUgL8a7kzb1kugCm2OV2v+A2srgnGks2Y+6dzv
         S/MP3jgUm1Vnt8uGApTYrlvSE4u0M75sVdeJr/jkR5PUO63CEQD9EsRaphLlmjpA1Qr+
         KY+1xjHUY/p53vOgW5EWByLy86KPPTnybbx6T7WCkJTg2aCERF5zEjIp92ddmUkxcq9V
         90BQ==
X-Forwarded-Encrypted: i=1; AKwUvBx49TmzxSDWECGGEt7ZAr/l3GMkCOFAX610bKjRHKe3PEuk2E/diLiiYYFwXAZxcc9mULk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSzyvRHBaW9CkISd4WfJvg3mE/pFt6xrrD1j03GGmTTSdNo/B6
	vnPnEeMbSbdiV8b0lI6qucVMh0yTQ9RvLAwX7un2Nui3UJLND0jh0mtm
X-Gm-Gg: AYBFou20zop1aZFpjF9MGTzC3pRkUHntVNh+taFWCpxxXA9RK2SoOTG/BBcVvY2G9Xr
	v0B/NIJab3IeIkuE8ORgkQapyBFauqG9/i8OJ0XL/dgzbqVIfOH+TYwnysyClLo98mXzBQEXFS0
	7uP5qotVULI7pJl23JkqX3qd7I1FrjxuXXsZZviK+WIBNUtKgZES/FdCbNU0pY9SHKuDwrf31K+
	Yxlbvcd/2SsgWirBAzlejiV1kieqFCPbAtpLSc/x5sXaL7ID9kmP0/R4Rzrbxigx3K+YKQJnCIJ
	jJ8KsYRU5P/TpK1C2Dv1SbK2dX4dG5TV9sbVxZ1PcfqDaT/WZ5FKRXszmffG1Smy1GrhkbGCAPw
	kJDQrki+Dv4IqopV2J3AdoJ1Lqe2gBvk/dIEZ3RbgOnbK1MGICYbh6146Swc4+9tnkxR58bFaxR
	mWQ4VSnteAQO+TSnmZTGW7GKmKLx/TwhQCVp3e5BD2wlJJSpFSpTJIraGo62rqId7QTExhZa4O5
	BkUQitIu1j+9ZjsJQcnHb9MsJyRcafEdgkSFsDGLj5RsdUr4gmCIajDg1SpN+2bJqUf1Qt+OP8k
	HZKTWDrGAZXztKEhRaQp+FaAdGnD/fOk3y1F04LXvBS1YFjYCvPV85HQapxN
X-Received: by 2002:a17:90b:2645:b0:3a8:878:ebab with SMTP id 98e67ed59e1d1-3adead4c29bmr977187a91.35.1792813426692;
        Fri, 23 Oct 2026 20:43:46 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm688046a91.4.2026.10.23.20.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 20:43:46 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Oct 2026 03:43:45 +0000
Message-Id: <DMCRBHQKJP8Y.1KLS4ZA48PV06@gmail.com>
Cc: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: Re: [PATCH bpf-next v8 3/7] libbpf: BPF programs manual loading and
 attaching
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>,
 <bpf@vger.kernel.org>, <andrii@kernel.org>
In-Reply-To: <20261024014514.2959514-4-andrey.grodzovsky@crowdstrike.com>
References: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com> <20261024014514.2959514-4-andrey.grodzovsky@crowdstrike.com>
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

On Fri, Oct 23, 2026 at 06:45 PM Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> -void bpf_program__unload(struct bpf_program *prog)
> +static void bpf_program_unload_full(struct bpf_program *prog)

[...]

> +	if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL) {
> +		zclose(prog->fd);
> +		return;
> +	}
> +
> +	bpf_program_unload_full(prog);

No need for two kinds of unload.
func_info, line_info and subprogs are filled by bpf_object__relocate().
Nothing depends on them being freed in bpf_program__unload().
Let it close the fd of any prog and free the rest in
bpf_program__exit(). Then bpf_program_unload_full(), the strategy check
and the second paragraph of the new doc in libbpf.h go away.
Do it as a prep patch.
Something like this:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8fcb8cf..dd15842 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -876,10 +876,6 @@ void bpf_program__unload(struct bpf_program *prog)
 		return;

 	zclose(prog->fd);
-
-	zfree(&prog->func_info);
-	zfree(&prog->line_info);
-	zfree(&prog->subprogs);
 }

 static void bpf_program__exit(struct bpf_program *prog)
@@ -888,6 +884,9 @@ static void bpf_program__exit(struct bpf_program *prog)
 		return;

 	bpf_program__unload(prog);
+	zfree(&prog->func_info);
+	zfree(&prog->line_info);
+	zfree(&prog->subprogs);
 	zfree(&prog->name);
 	zfree(&prog->sec_name);
 	zfree(&prog->insns);


> -	bpf_object_post_load_cleanup(obj);
> +	bpf_object_post_load_cleanup(obj, true);

I really dislike bools.
bpf_object__close() is the only caller that passes true.
Clear obj->has_manual_progs there before the call.

> +	err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
> +				   obj->license, obj->kern_version, &prog->fd);

After bpf_object__load() this loses the fixup of the verifier log.
bpf_object__load_progs() ends with bpf_object__free_relocs(), which
frees reloc_desc of every prog, MANUAL ones too.
When a MANUAL prog has a CO-RE relocation that didn't resolve on this
kernel, fixup_verifier_log() -> find_relo_core() finds nothing
and the user sees
  invalid func unknown#195896080
instead of
  failed to resolve CO-RE relocation <byte_off> [..] struct foo.bar
The same prog loaded between bpf_object__prepare() and
bpf_object__load() gets the proper message.
Progs that depend on what the kernel supports is the use case
from the cover letter.
Keep reloc_desc of MANUAL progs. bpf_program__exit() frees it.

pw-bot: cr
