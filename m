Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B52D592F
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042038; cv=pass; b=rTT9vJ9I/B4PgQrLr6UAaj9RhiytOYlaU2e1PTPZF6kG/JNnX/Vk+J7ZILa9kuyW4RkJf7hr0aKjTUtU0i0haKhcqQWV9bGrJa7c5OKnFCjO1m6ctXNYM2EF/U89GKv91E7QIAafy13ih1+yWWts1G9h6dhWmlSIey/jEzmMeZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042038; c=relaxed/simple;
	bh=ys1EeTaGO4MV4C4zRqUcLdiLfUXHWoz3nDJ9U8hLerY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmnnDxwPIIorhD2rTmjwTnDyk1Qt2bEtkpM+IO4IFFyHHQmh8F21z3kyff57JllUX7QjLF27Ib1NqW9nh5KmT+R/AzQWt64Cjn5HfjZrfnE+Qz9rACvPMgOfw0ooGnTm19e2nJPPxn+eD5KzsbUsbXEDT+Epququwib+Zk+Y8l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dg66wscw; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dg66wscw"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5069a785ed2so10241cf.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:53:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772042036; cv=none;
        d=google.com; s=arc-20240605;
        b=FOtgZ7G7dcgIAqQJEnbl981fwSe6Buu1fhhTaCuZo4yFT/Yy6z1gqWzua6LkLrPGMZ
         5vec5BT+hTwOg+yKXo+OPFxXc8Tu7X1URbNow4Laqu2MCwEcKo9xEHrKV0LpPs2L6bIC
         /zZE6hA+HE5E+bTxrqlqjKhi2fx5UZqEeEhRwtAEsWOmvjVZssC9gnEBD+e98Y+Xc+4g
         QeJEc9JGZsLspzBgvlKrcsjD7q3JdCfZqK8NVOSIvmrkchMuJRhY1OCizCAkIv5eImfp
         xg4My12cw9DYBglyVLvikJRhAIfiZqnrsIr44Pkn+SxYBvO3AiPNoiUlTv/mhV4R5+so
         UyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jEAVieEU+20sbk3t3ofcLww1+yuqfYhJTzzkm2s0tRk=;
        fh=7CNiWmcCwfShlbab4Ue6Npihl4YPZFzDvn70eUsZ1Eg=;
        b=iy8axTUhtJI120O16SjFkJwqcWbAMIyWtMDgC297XW6sMTSCeX5VIWX3MP+0+VJZjd
         c5G/fUiJRhD9ueHqkLsN+BW8JxUEtZZLPhECXCyGGIyO1JnOqgpoZKFRFOFtmuZl2Dh7
         h7edvoYZORSclJVlvWDeq8WMMH7DUZUjpRw2CapiSaf2akWmKPiXSpYfEW3kd8Q/f79N
         P+/CxhpVAvHM+OX7xFOqE6WNRD2U9jWvcHeDzu9O8O2fLNFhWFAHrCO6YeUXZeEZPQJT
         fm71uQKfTEpSYReFrY4J4f5pthSn+G9lmafNtepHmTEBb6MHIdxA5JZejsUavl5884r0
         w9AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772042036; x=1772646836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jEAVieEU+20sbk3t3ofcLww1+yuqfYhJTzzkm2s0tRk=;
        b=Dg66wscw6N6PMn/Ic/J4yMFXqyIQy0EvHM5RwDUcHLNKp69BbfzzpcmBvGkfa/uBji
         cmGEAzVxetJSudoAvNIkpepYGTR28qm3Velj4NHXYmIIwRYyMY7Azzsiyd2hPiWukXkU
         ah0DEXsoWAJSgGbg1WrPUo1K3r4fdKOZ1DtDtI5SScIDxjSbfNYOfw8lmcENqTaBgdNL
         m9bLbqzrlTtz9xkx4Fr9c0j18v4AEhPudr4WUkp4bNXprRay/tM5/nceRISQPRVRNimh
         kNCwj5rs+NenKoVC42dnJZiKwirAiJR8yZ4fHu3DoPWXOAaeIMiwYCRlEHghMc97Srv5
         3CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042036; x=1772646836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEAVieEU+20sbk3t3ofcLww1+yuqfYhJTzzkm2s0tRk=;
        b=F6lKzS42SCMDLoIONEdGalU5wmKksPXrWupAMtqlfV/TPv2mTYE1xUVgGiiYTyxRdk
         aTG4KR+R76JAB5KuGNmzNZz4rabAlJYpskFW/tduangv61DFQdioYjdiW6g7im+uTIZ2
         GZ1hf/qvfXDT4LQpT1PCVyUVb1mtVaFsCOnFAea1k8EZv+gE8IVZt76Fdyfa3s4qYsT7
         Ssr2uj2i0CJEsBmoo0V8xXtv0HTCFUAqJA4WRS55lyOToub3IzVMFFwEQSmOpglrlmSr
         jM7EP/Mi4ja7cueZDwH4xOElSZQKQlebGl358azIdxwzl/l7skhuOU28f6RQyNnK33Vd
         W5cg==
X-Forwarded-Encrypted: i=1; AJvYcCWyTRCDYgbAjLMhXhykQ2WLTPy0xTze63LP+83hk6dpmHvQaB+zP51yWoLPb6lvFKEzACU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGM86kRwJlE04D41D1d+wBkBGRyNI8OfYmIutuM/88bbODau6u
	m1eSiYgOv43vRwUVgTuaK0U6dg5GFXezAEPvo6QY6IHRBHjZRkMLP4RmLpta00VwjmrEp/jeaCI
	+aexbK6iJv1bwIKJ2mYS/ZHcbTxOecFZubCkHv65p
X-Gm-Gg: ATEYQzxRih/LBv9MK2EYKZT5q+y9jEkK0vlDdcUCPWVdiz8bW5VyTfMy8nZyngdCIwk
	OF+nqEpu6FxZlL4PtNAiHluHk9FtA9t2JRdyIDfsfYPqxzvCuwz3lgstbvbPygWOWJT1firNGbR
	UI7U+MJQ00uNSv87khtctjJtNQflJdJsDZGn/XiD2JBHcbSLJQ27Kr/u9Alarv35YSYDr9lS3j6
	luYgVnmLx3KOQiWE6FKLV/kMdava4V+mXMXxcwLu8iCns69Fnp7wwGJtraTpvdjBpqilNQ58To/
	+T3+4pks
X-Received: by 2002:a05:622a:246:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-50738e19028mr11538841cf.12.1772042035314; Wed, 25 Feb 2026
 09:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224093128.1926610-1-tabba@google.com> <c402e95a-26d3-47eb-8249-52ece97989d3@huaweicloud.com>
 <CA+EHjTyXWqnr4Cu_cZyxDCVNCxto9pJN0WS18S_ri824oQhwug@mail.gmail.com>
 <2d0c6893-d4a5-42bc-a480-55bc669da130@huaweicloud.com> <aZ81zpP6ooG_19cI@willie-the-truck>
In-Reply-To: <aZ81zpP6ooG_19cI@willie-the-truck>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 25 Feb 2026 17:53:18 +0000
X-Gm-Features: AaiRm534zbpWWOEgtIxfzMhryUNrf7luuF1GuBsHMOEjyqDn4wuNqe1tCagnydI
Message-ID: <CA+EHjTxxqr1fTfDrFwpij+92BEATbYTWmOKqtDeo5jgfqqCsFg@mail.gmail.com>
Subject: Re: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
To: Will Deacon <will@kernel.org>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jean-Philippe Brucker <jpb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Will,

On Wed, 25 Feb 2026 at 17:48, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Feb 25, 2026 at 05:46:52PM +0800, Xu Kuohai wrote:
> > Interesting, I think the plt target should be 64-bit aligned to ensure
> > atomic reading on arm64. It can be updated concurrently by WRITE_ONCE
> > in the bpf_arch_text_poke function while the ldr instruction in the plt is
> > executed. If it is not aligned correctly, the ldr may read a half-old
> > half-new value, causing the plt to jump to an invalid destination.
>
> Thanks for pointing that out; I hadn't realised that we patched live
> PLTs!
>
> > To avoid over-aligning the entire buffer, how about fixing the padding
> > method in build_plt to just make the plt target aligned correctly?
>
> Makes sense to me.

As I noted in my reply to Xu, and keeping in mind that this is very
new to me (so take it with a huge pinch of salt), I don't think this
is correct, but that my original patch is probably the best fix:

> I'm not sure about this. If my reading of the code is correct, during
> the first JIT pass, ctx->image is NULL. The current padding logic in
> build_plt() looks like this:
>
>         /* make sure target is 64-bit aligned */
>         if ((ctx->idx + PLT_TARGET_OFFSET / AARCH64_INSN_SIZE) % 2)
>             emit(A64_NOP, ctx);
>
> This forces the relative offset of the PLT to be a multiple of 8
> bytes. Therefore, it assumes that the base pointer (ctx->image) is
> also 8-byte aligned. If the allocator gives us a base pointer that is
> only 4-byte aligned, target will end up misaligned.
>
> If we try to make the padding dynamic based on the actual address of
> ctx->image, pass 1 (where ctx->image is NULL) and pass 2 (where
> ctx->image is allocated) might disagree on the number of NOPs
> required. This would cause ctx->idx to diverge between passes,
> breaking the size calculations and offset tables.

Cheers,
/fuad

>
> Will
