Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A325FA29
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557770; cv=pass; b=oSD/BcGPg1qRJUCYzHom1YNqXkdOE4W1AR3zh1Sa6eU1v6CmdtlN6wqfek9Qrqrls3Pc5ouBaXowBSYws/ut5YbURBx4r7aXfk9Y5cKJDpn5biZ0RjiboVFYO5x4cn0gZVW23tWsu9heHEu+n+GMGSip1grQalrbVTeR6uoYMUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557770; c=relaxed/simple;
	bh=cNpkDX0BDVaZgYsQOwr0W9tB0PAwYQjSLdRrLI1T4LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwj5q1tHYv4JbDPpGr8F8VewU07m0UNj5l0f+OEtNU2MS4NWiFgoddyr6iadgC6MgQtoLsuMVoV45oVaako0tRxBXhIHFRaYa+Y123Y85cii16/HxdhbbzBlPDBgvfgKo+JheHDqWDB6Z2kiulYYua8SZ8iI9wSjWlhXiDAokTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPOURane; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPOURane"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso4358190f8f.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 20:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778557767; cv=none;
        d=google.com; s=arc-20240605;
        b=hT05fjaTZHSynY1+jOMl2j+suOrX5U+jVSPbxbf/7QyVDl9MkWUz9JHw1r0RSzyMNE
         ZANx2qtvLDCRPyhaX2ucdMGXQ34NIiyGF97Q7FNHWKrzCrtuYip3mYSUkDdIaK/z64xb
         /+AKk9kC3NTems58mlUHAlN5uuITflvXnPsN2pTuqNUOmfxiil1yyYLqgHbhE9QtGk3P
         mJZ3spfT3TOqcvJJLuCGbrTFd3WXARppQc4n7Q/CklqkL7WJrbVMxwyM3CMgnr2klDCv
         2PTyDOsFC5MMDmEwm3FALg5kjrtDb782ekDtLR8Z6rHUjRXNdxR/hEvK59yEG4Y5Tzkw
         tzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cNpkDX0BDVaZgYsQOwr0W9tB0PAwYQjSLdRrLI1T4LQ=;
        fh=q2nMWWvhAnerMKk1bwn+JzYjbndq6O+62/4hDkMnQvg=;
        b=aTEXZtbWJgpIdsxMxTlBCs6b/cHzJSMhiGM4U7cQPM3KkIMsc2+3exJIYBjpFMhWqY
         zdMAQF6NHa2BivpFasLR21b2qh+AR9ldx1KnL2rKBiYsMa0EGqEFc7MXJrHWBHd3g/Gj
         JPnvP9z+/iUWJ0tpWHUrVOULlkJ1i3aTFxQ89WVfIjVv2hB9B7CEBpe14MF2mt03Vlhv
         95asGu6qb89xDjL840KQT6q8Osko6AzZueWUqD74OnRNeG2J+H5tNdlX28At426CFW/A
         k/TgVeORcppFXYjdo10bRFpb9P2Ft4sQg717+lNwEPUxxE5v1YQ3AB7p9x/HEjJmp2jO
         UeOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778557767; x=1779162567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cNpkDX0BDVaZgYsQOwr0W9tB0PAwYQjSLdRrLI1T4LQ=;
        b=ZPOURaneG4hLJ1tc5Ztgo6vRlqeu8YL4xyTIwFNc2Qm+qRAo1RRNC5V9ZHhQUMCppo
         YahjHiOtKFBHgJsSGhCYpc4Y0RRJeKMiavq5WfHe8JWz4oCCGkHaMVph2qFdSy4zFcSS
         wJiwTGk6auRCjbJl14qTZ1SYyjH0yLsRJex02HFDlUDwi13OGx3w3duVmL5iNfy2TpZV
         A3oxgUNhF4WIkZ7Kj3JgiKV0msEc62cmZZWTStVl30duPMSIip+MhCLLKULKTQhwWUxx
         PgXTaHtOZyxvQ9yklKUqLyV2gCRIHKb1iYU77m/e2z+andjcytmLE+Y0Eg2qBl+KS7JI
         HhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778557767; x=1779162567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNpkDX0BDVaZgYsQOwr0W9tB0PAwYQjSLdRrLI1T4LQ=;
        b=R8wtQNXoCo2rFMriv2S8Spa1302HSvVP2NI6M8PEkPgEs5JonI4W/8LnvVQOZDmjAz
         dODVtDVtNgB+bIkiP2afLSQ0xgS1n5sEsttmcGQwsYhuGAxlKaJaDG6PRHqJPaswUeBF
         EfGeglwjDmEYW8Tg30QM8U0Nk49D6RRGDYsejnskoiSqY/rUxxWebt9AtiswQSwRY3xQ
         gkVsFPzzREWdOfRRImDhow7KPHlWBKezl8o9knga9WRytva9q72vsT+moelPg18gXUAR
         qYFAiWklJj9czSDgpZiqt3jqaAeQioIY3Fn5DXOmaWglPoMtUxc12iJEC+I5Ng1Ouvh0
         cbag==
X-Forwarded-Encrypted: i=1; AFNElJ+1Tr0d1aKb+wSSNcFJjHAueki6kSCkUsXW/stgnGesbargUGFFblik/USvSQjQx1YXLUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDUqaOTYbL8MNsqONpKno8lwSvxmXdqkBKYB87wurNc6C9kGS
	JsO+2VMTQz6JgxWF2AxZ07GH00Wrru2RtNYPVXmbPjnvXfroF0Gtntw+VzoQnGyVGd+Jj7xwNPC
	tGHZncvVp91KxWGXA0O0cGwe7DuA8udY=
X-Gm-Gg: Acq92OFo30VLLzNxLyFcYP3f/n9sTJNIQuXq9FJK4IrYQ0DEcH+LvwmlvqIvyxi4fW/
	r5U8fi3OK1sFjy2BTXwhNmev5v6VDAR8SLD9+pXrfra24dn5O+lN0OJoD5/gSwSF0TclK9jKc6h
	eRkXrrSUt7ohvDABuxa0n1XIUW90IhLDfI0KoXZz3dak0LW1dJHz7kATdg4aTTQ0yylTrtwlcER
	4vE124r/FVfq2IKO46ixgb+oYHyr6XgdQg1oAm0I8zvi9fKDMIujBxFIIu7nqQomPfb7MJ421DS
	tQq6tmFygnPQi9dsoKRxe1O0gu7EJW4n/hShxxon7WD7HX8YZ2jsYYhIsg51cKabRtoLMe+1GeS
	eD13eXCOmarTcAlhqlSVL3AC3wFLb4wqdqT4S1KYJcCl2uSnsUCnnAToV
X-Received: by 2002:a05:6000:2405:b0:43d:6a0c:9571 with SMTP id
 ffacd0b85a97d-45b11a9c4c0mr1208157f8f.11.1778557767056; Mon, 11 May 2026
 20:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com> <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
 <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
In-Reply-To: <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 05:48:50 +0200
X-Gm-Features: AVHnY4JjCiOQf4uv2FRXJ9tMO-x6_X7DpY9r7ppXx4IuXM86_v94QiBUk_uOOH0
Message-ID: <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct
 kernel access
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 05:25, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
> >
> > If not, the best course to me seems to be to make the flag behavior
> > default, and just rely on ASan (and Rust in the future) to prevent any
> > memory safety issues, and drop the stream based feedback on fault,
> > etc.
>
> Agree that this needs to be new default without new uapi flags.
> How about we tweak the idea further.
> Let all arena pages be unmapped initially. bpf progs will fault
> on them and will be reported via bpf_streams.
> But we also prepare one "scratch page". Let's use this name,
> since "garbage page" reads too dirty.
> When kernel faults we populate pte with that scratch page
> and let the kernel code retry.
> To implement it the page_fault_oops() can have a callback
> into bpf/arena helper similar to kfence_handle_page_fault.
> If fault address is in arena, do kfence_unprotect()-like.

Interesting idea. So I guess this page remains mapped once kernel
faults on it. I guess we can still reset it to NULL if we alloc and
free a page at the same address, so it's just a drop-in to prevent
further faults inside the kernel, since emulating instructions is ugly
and we're not using asm wrappers that have fixup labels etc. If we end
up allocating and freeing something at the same address it will likely
get reset to NULL (that would be ideal). But even if this happens in
parallel we may fault again and then will just fix up the NULL pte
with scratch page again. We can likely also preserve fault reporting
into streams when such scratch pages are brought in.
