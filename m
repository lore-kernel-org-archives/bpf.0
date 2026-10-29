Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291638;
	b=L2utMz1+wBfrZs+XFXPQ9iTsPHT4rKivZkKjo8+nhv4vRTRqw8HwLbdr99kd3HdbLdvt
	 WOx0l4+3hz/OmDrffWM/eNOEb74+8cD0813D0Zcp86sgnqi6hUeWYgNdlzF6OH/2hS1n/
	 TMDXTRkExmC3esUKDl6fKl8UKGPt3Q9JfVzhzHE+ZG85N2o9r2+0a/zaIYz45FSDI3xUH
	 JL09p3H8+2CbOa8/uDEJl52ypQr/y6dIATbeLtK3r/nKGZaWuwsIysAFJA7ccelEUGeFc
	 ElKWarX2tQayrmbbmboIuw4HAxacl0EujrdRUmn6iIrydsmzi/NUgXHiYjKeZ8FG6rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=AUEgA+KIhVNOjMXzh3FXk0P/lrvgmm68bIk2PmEsd2Q=;
	b=Rog9TnVJMWydWcJdyU7W/ul04UkrLxH9aSGgBfjaeeEbHS8DZbueWF6PoyLywO4w2FQD
	 JDRtX40w/puBJ6VYUqkN5tf/aUh4FO7lk2EE34ucQVIW7uhOOB57y4WChvWFl25d1mVwz
	 6V9JUv4EmmQxwcGYCvNlztgAMsuC1ktlVafVzYBfN8OidFveidjFuUWADzzVHWqHJECBd
	 REVDZHV1c26uCy96EjirR+EekPm2VyoOv35kcSiS8lGACxu4sJmIOeJ9L9O45Q0acKgD5
	 6JxZiAnE3afP3lFAyiwI5vas99F/MmirevrJlYXP6garQXOOEwQFAj0JlgSnq5lC0YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CRodfhJe;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC9606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 16:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FEC9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CRodfhJe
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso15424255ad.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291638; x=1793896438; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUEgA+KIhVNOjMXzh3FXk0P/lrvgmm68bIk2PmEsd2Q=;
        b=CRodfhJeEOikU0i+dQEuNpBaaDuycDWWjkuIV45tbb06Q1oe98Exbp4+RqKKNMYSEx
         WqHz6cusTxgQx5H57r4dL54D4B7825h9o1QGCamhOF0IueIDECAWTyiLzrLUcJ05C2Z4
         xuYSKCEvkN5rvq9P9J0pDcoLjoLM1d1taYXoUHliMo5CLG4HqJkdBEpQX6RLHIOZTfaE
         y+v/w2FDE841G4y9uutJ8gNMvLvbl+gtTwP4YyCKDSMFbUOPZ1rq51gvgJpTJEVtnePO
         5dY/aQ88F7VH78L8H8b97AObets7WjHiAYntCB0SjNFspam6J4iFmwxt8rdOaOSKnNh5
         ChkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291638; x=1793896438;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AUEgA+KIhVNOjMXzh3FXk0P/lrvgmm68bIk2PmEsd2Q=;
        b=aqvcoJjKbO3DipBqX5eUz8Chck9ycuVlzi69vWQ8M2DI8Mk3I4+5zY2/+ZdNzf47SO
         ibo5dFQq5gVY1WGeIWD1SX34dolLz3X9J/1tD2qs5N1CS77jJgYxRi4nsJBxMXYC9Rnj
         r0l0DnoeWIqcThxXskj/bgoWrUuLCyjw9CdhRbbdTfD96wihMw7YXeSw4aj6V2L9ET/P
         3yDerQJEW3DjGl4gFUW6vCa/NQKPKzDxOUbCGJywDl/J939qcM3DPjwDnGC4zaXrQwD4
         cgCgG4ygrvhDorSrQDzAOvxpU1dDpxTF/OCKcOnLH59S5dCunof+UTuf+i2MKluGGzFa
         FuEg==
X-Forwarded-Encrypted: i=1; AKwUvBwLkvSGoC2biTei3e3phwVb97vKgi56M5p57XJIiwVu5AMv5fQzhhBEkLalgklQoe98c08=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOf1vj34Eie/CK2giXP5Rn8GrgSxUBSb9v4y6wRdcGcXnX0dUv
	R0BF5xeIaYplVSPEdtE9i1ICRbJJWDBM5HueMeyVwNjCfS4l+KMDWlSSqznJog==
X-Gm-Gg: AYBFou3hhH9/EyuREcZspdGfiTncbbcx3pC+AZKmjBD4s3oBIACYD+lWy75yZzGBiJg
	eoMlMliXHE5xkO8UNSFlU71SARdlCOPge7LGMb7x5ccs3Z8/0TVLx2wqH6wf++xigmKzhh8RSek
	CGnJeg57I80vYWCeLGvYalGwSH6D832wFa3A3ElZqz0iOszolb2LTrxpHPPCd1mvRWolDt6tS7Z
	F0aSRlKFAdudUT+51K7lzznbPT14DJasHUatc5bgDX/6VQiaExe3fic6l/CW2SbWpFWWG1WmhwL
	EW4FLu/VxVmBI8tEn/T7T50hP/V3okFIGnY651KFCVTSPV+AjvSnWxDVDbi4PHazxibo/EOocWf
	Srhkkc7UMthrvjCVykQm41P23/lbgHBMTQ4gPNEd7+8Bd+SK2jcd+EcpmJ4Bq0iG44hh5Bp2n1P
	jZAsYGI2X6nZKuRX0vdMMyIvuIlzIDPb0I3X9A4x4jNrukF5FO33U51Gx84ODl5m+x4nYm3ATOU
	XrrHo8n5jLJRIY9shmD1xcI1zxMnfnc53fP5PSjq/BexWYnziXnBkyvVOIBydLrMYvClEV0A1wZ
	fmmbAcFJG7vXw5G+wUlbEkXfHajM6neN65WMhj9nHAQ+a+cOhdCV+bIimWBE2N55du/ACfGyY/r
	R5K4lJrBIaxRoVtpFdWDgHI6x8/msW3hZkg==
X-Received: by 2002:a17:903:faf:b0:2e2:bfe8:aa7e with SMTP id d9443c01a7336-2eb000852dbmr59313085ad.7.1793291637435;
        Thu, 29 Oct 2026 09:33:57 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb361f392esm107005ad.3.2026.10.29.09.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 09:33:57 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 16:33:56 +0000
Message-Id: <DMHGTWQSAWG9.NUHU0WK9KRK8@gmail.com>
Subject: Re: [PATCH bpf] libbpf: Reject excessive program counts in
 generated loaders
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <linux-kernel@vger.kernel.org>, "John Fastabend" <john.fastabend@gmail.com>
In-Reply-To: <20261028183947.9606-1-mahe.tardy@gmail.com>
References: <20261028183947.9606-1-mahe.tardy@gmail.com>
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

On Wed, Oct 28, 2026 at 11:39 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> @@ -122,6 +122,11 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
> +	if (nr_progs > MAX_USED_PROGS) {
> +		pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
> +		gen->error = -E2BIG;
> +		return;
> +	}

nr_progs is obj->nr_programs. It counts subprogs and progs with
autoload == false too. See commit 259172bb6514
("libbpf: Fix gen_loader assumption on number of programs.").
Only a prog that reaches bpf_gen__prog_load() takes a slot in prog_fd[].

Two objects with obj->nr_programs == 33:

  object               today            this patch     should be
  -------------------  ---------------  -------------  -------------
  33 progs             -EACCES at load  -E2BIG at gen  -E2BIG at gen
  1 prog, 32 subprogs  -EACCES at load  -E2BIG at gen  loads

The second object fails today because of the cleanup loop in
bpf_gen__init(). It closes nr_progs slots of prog_fd[], and
prog_fd[32] is at r10 + 0:

  r1 = *(u32 *)(r10 +0)
  invalid read from stack R10 off=0 size=4

Lets fix both: clamp the loop and check the limit where a prog takes
the slot, like add_map_fd() does.
Something like this (not even compile tested):

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -139,6 +139,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
 
+	/* nr_progs includes subprogs and progs that are not loaded */
+	nr_progs = min(nr_progs, MAX_USED_PROGS);
 	/* amount of stack actually used, only used to calculate iterations, not stack offset */
 	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs]);
 	/* jump over cleanup code */
@@ -1134,6 +1136,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		gen->attach_kind = 0;
 	}
 	emit_check_err(gen);
+	if (gen->nr_progs == MAX_USED_PROGS) {
+		pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
+		gen->error = -E2BIG;
+		return;
+	}
 	/* remember prog_fd in the stack, if successful */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
 			      stack_off(prog_fd[gen->nr_progs])));

since it was already applied. pls send a follow up.
