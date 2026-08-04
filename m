Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C6480335
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873930; cv=none; b=IrXDHw9QlULEvyieftUkDn7udqzWs21WbHZjN/hImOTcpFFKM3obPnArP2dGu6SG64pTeqSXvBMYw3RSaoOURfN9Y3faCdB6pdDzW/HZOm7Dz41cSCS+hRDIuNEkH0cuom0RTLmGqR59ax1oY7z9g7TEpPKKLobWN1Eyx3jul9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873930; c=relaxed/simple;
	bh=GdwcaSnOAIozmOYiKiwMg91J8UbmPOytKa7VQcon7Iw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmw7k2L3uLNDEBs5pyTWuznX8QZfEJwoR9p3ZHD7otsz75qwC8RjHbbRq3aVhiLgFX4abtfENaPiz366w6pu9SrZWN68UK19KrPIh+ZZU1zDwmVtvDWtuPJoQTtZ8LVNqRNUSj17bCVX+I863Zm4aC+pxsMIjBGXWZQ9sSogd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neubdtl0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neubdtl0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so138051f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785873926; x=1786478726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7YidgDdxzChz7kJDHI/X0ctrGJGdxKGI1valsQ4qlGM=;
        b=neubdtl0E32tiuC8COUfzoFeuTvkWjDHPh2sMLgX4NQQhR3t235rcd7Vd1SyemTBWv
         03qOjUkDuy/5DbhQ5hM+7iXa2nqGj8UPUsPipaDjIrMIOHi2UxronDA8x64g8P2twK7N
         iReVxfXwwlKSE+n26sCldnpaK1XfYS9Xj3MwSluEgZPuaYZyEnVFkrEM+Vvery59iMZ6
         54M2r8H26zCgVOEYEBcc/cu5JPb+Yh46yyScOevwXeeDjn2QUZmra0J4mpURBNDyHN7+
         sbnsLP5wM6IvspVcrBc8stT0mUAk5ZdznqV8U0vKvRFwgLYhhMHokIWeXtWDvP4//n74
         tL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873926; x=1786478726;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YidgDdxzChz7kJDHI/X0ctrGJGdxKGI1valsQ4qlGM=;
        b=CuEVAT1UkLOkgY+7PZjP3x2UUXOJtGXPvjniH53pNSHXNvytU3zYs+U7j6pjKW4SUG
         Kw/5hPvV+dBuzrrLevIQvW5LEbiztSgFpGmrh5Y9+U4m7IhovGgztQF2Z6tm19b6lAyK
         d2XgyPgGWbkFo85zQ68/KjfnK7qjm0vu5xuOMuqL04H9RSUQr6vACSldeoH+8vNfyvD0
         aH8OtcVgB11D9mnhNZATvC7vnGuqIwmLicW5KRQ1uXOkB5KBpuVYKqn0y4SxGLvSvEzp
         X22wfMV/c/wGgP7TcjMivCeVALmSfQbQPWVeLIgdSlqWWkp8QrCTPjb9saYAz7mekRMg
         fy3g==
X-Forwarded-Encrypted: i=1; AHgh+RqTxjMSD06jakZhh1hAXyDHr9vhRFIliGNAIAR/2eVCM4SmBdtjDU1IJ0/hio+Vq9Qj7jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5761DMvaljJJ9/tGFKFhjAX39zfC4RfOyu9U8fhuFOo2cpUWa
	UfKtwS4iP8sEwy/AbxVIhd0OHOCQBTApD+YxZrXx9SZ1wnSH0DA4kKSG
X-Gm-Gg: AR+sD10SXZBJICPslIux5ecW7C0Gs+nomUxFk/CVMISWtmp1b7yry3PTZ9lPYHtjTNp
	WaOG6LnBwb8UmnU0+GhIZXLT9U3XzhnDXYR2/oKniYxLiXHMK8CqgvxkZOkfToXswuqqbsB8o9z
	3MIs99TTGhS2IQeA0hl0Eo2iOuc1rdAv0813VWMuTdzX72LLxja11mEy5eXg8eselh7MpEDJx6y
	IzS5m9x24mGIXm2JLMiaB+gFr2DdviVxc7StfLwEKmoNTr2zSx+FkswZ2piL9vTQdnv2ooI8I9w
	Mr5GrRnD6riKne+GEUl36GPwBp3dyO3yfy9rURDA+xt0NiA73Qo/kZTXRlUESeTWePq71XzHyiO
	a09H/pKiU3i1b6xahAwgEzx5kd8OMhuBs11ub7nmD9GDfrmGiLuy83jhJFTi/qchf3UZiJ8+jUF
	3rtyEKVhPEl+cO1Xtl+EYZOrSK2tHeIIrz3v/b0efObVOm42p7
X-Received: by 2002:a05:6000:46d7:b0:46a:8fab:eb44 with SMTP id ffacd0b85a97d-47fec501abcmr2014403f8f.1.1785873926243;
        Tue, 04 Aug 2026 13:05:26 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfda6afsm2553778f8f.3.2026.08.04.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:05:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Aug 2026 22:05:23 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, qmo@kernel.org,
	chen.dylane@linux.dev, info@starlabs.sg, contact@arnaud-lcm.com,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 12/12] bpf: Avoid changing callchain in
 bpf_get_stackid_pe
Message-ID: <anJGA8BeXZN74o_J@krava>
References: <20260803210149.296496-13-jolsa@kernel.org>
 <55dbe83f00c89646b6abd5b3fa35783a8601cbc6b380fb856bf53490e35faf49@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55dbe83f00c89646b6abd5b3fa35783a8601cbc6b380fb856bf53490e35faf49@mail.kernel.org>

On Mon, Aug 03, 2026 at 10:06:21PM +0000, bot+bpf-ci@kernel.org wrote:
> >     bpf: Avoid changing callchain in bpf_get_stackid_pe
> >
> >     There's no need to modify the trace object bpf_get_stackid_pe, we just
> >     need to pass the needed callchain length in separate argument.
> 
> This isn't a bug, but should the first sentence read "modify the trace
> object in bpf_get_stackid_pe"? As written, "the trace object
> bpf_get_stackid_pe" parses as if the function name is the name of the
> trace object itself.

yep, will fix

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30854471987

