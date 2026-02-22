Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F01891A9
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770778; cv=none; b=aZdJRJQSlAWsw3FxDnwVHrEReM/qSoUOuVLrZv+5AlpSho9SdUpYz9I5BG8grcHk3pZGHNdM3GFS72ZYVX79AVbSBOY804t+70zkaNQ3LFbPylzyOPLXDi/GX2QP8sxb9CtPMicVW75aNLd3zl/JKAlQEPRlFF2w9RLiijovL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770778; c=relaxed/simple;
	bh=dUq0rzBAAkfsWt2gK28+ZSsxn8oKN8Vf+vadyIZcte4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK7Tg/dLsS2edkGn17m3Bewq100pQnVcCGfdphlM2Yg2CRoyAymuaHVWtj/25G9/NJQGcmrlkT20frq2INu1lSGJ/Q71kATpMTsLmPP70iFRGhx42b4Jm0mxsuI3965vNaIKjT5XmOgD2L1WXwflWqEoUOjb+QBxgQZzx4hmVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO0eFmTj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO0eFmTj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso29787415e9.3
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 06:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770775; x=1772375575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f7aq2pfz43PvIU3dfG67UgP61HFVB3D3Ekwi/gn+Ws=;
        b=BO0eFmTjfy28gsF9RCotz4/bHN9REozstOFKGCMlb0HbTbWNrOLlodrgOUpR5e5ha3
         YlDAYp1S7h087ritceawGnEn8FW95JpDt5mSLRHR+vypVoCYQ1J+sOnvA5/NVyugIXTh
         ZvzleZ701oMZm089VPghaoT0peIBDn3/1vL7Bv51sKya6lB3lBDC3l16g8+VCsAHKSf8
         2Ka9adIYGOndNhe+P7ljCBBbXvxf5/W41LcKtYTfTmZZqn+5eGLXyVgIiV7A6uDUliwS
         77xUag2Ps//xkaWVbG+BOq1OPqOwaVQmj3Ny+/eYKEj0me4vsHwmjdL6E7IXAseJCYeU
         SfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770775; x=1772375575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f7aq2pfz43PvIU3dfG67UgP61HFVB3D3Ekwi/gn+Ws=;
        b=UnSNJNeOvaHDH7Wh6eVIOL4MUJZDQQLc7t5dyIw6q76lBbAYs3cgMmKy1G5A7Y0PB2
         NH++pKl3JGUY/le36ob79ITBlUmDjoyCsLiUQiUiILF6sx9dyX15aBF6QSQh4+bY+ugI
         ZxBxw3RuDUh/0Q/MWYatCSNldy6vqVs8CAFGh4LGPG9RjDpxvNHTNCmod2/dkISK7Y3m
         Sq9A/m3TsCeZie8H+MhPQ1DeH12i3s41fVu1p4dad383iq/JkDiwEYOeQuD2wfXpj3Ly
         q5wUg38vuYUIZZqhMtDgB+ECEahCBdW6vMMoOMCXVrbN7iKeBbieEL+R2RxkAXKRWVJg
         cx0g==
X-Forwarded-Encrypted: i=1; AJvYcCUCiA+FS0L1AMiD693rDbPa7g7u/85NHx2qlMcVj3xAVL51jYXaHkUkVMfn9PJjML8vldU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYiOgd6r3vOtuOP4N5OIziFBiD9IfsbmpCg0bqzByvuB/hBgXp
	qkClHAsEUnwe39Uc1n5ged0ccbGkmCg4CWMrq4CgaeeWSMi1XC6M0RIQ
X-Gm-Gg: AZuq6aI3ddbPcFaTQPPEw8ZGB+udzyhkkH7zFbfno0civtPuzwhWRCwdiDiwdwaxnjQ
	ID+irIE+GeTr+3MCediJAzxJQbo1zfcPzFJzgrfzUvgeXqYbEdzL17fVm68otoeCYdCNo2CW/t7
	fFCC91Ssn6b9N0PmeFX1vCJpMvlTBynqm2OE1/IfvtXAX+IMPI97RTGAyKwFpa7yUuxE9QfqtGB
	L8oIbBgj3O0tWrePeMbaWiI39RI64TcmGWBpVnktPuURp/6cFrVYOUuaAmKU0nsPQzUEd3u39zw
	6enu9HLYozTNToiQcTFF3yAfCC4b7DGgaa+8NcLu+VGg5GcvzhEq2RmXBvzbDbbog6mt3rJz4pW
	IQzI30DeA8U3KfVVd/KMO8RkmNyCcoRnDYJ8sdCtF33EClOJUOSRjvOkI4w85UJQ8SiL+TU0p
X-Received: by 2002:a05:600c:1e85:b0:482:eec4:772 with SMTP id 5b1f17b1804b1-483a963de9amr81136595e9.32.1771770774708;
        Sun, 22 Feb 2026 06:32:54 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c96csm13652110f8f.30.2026.02.22.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:32:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:32:52 +0100
To: David Laight <david.laight.linux@gmail.com>
Cc: bot+bpf-ci@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
	john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 bpf-next 2/5] libbpf: Add support to detect nop,nop5
 instructions combo for usdt probe
Message-ID: <aZsTlJqakDLWzHqn@krava>
References: <20260220104220.634154-3-jolsa@kernel.org>
 <e46ea28bf48fb9ff5ba205036a6baf0427f7646870cafc98b387940f99a848d8@mail.kernel.org>
 <20260221120035.4562df85@pumpkin>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221120035.4562df85@pumpkin>

On Sat, Feb 21, 2026 at 12:00:35PM +0000, David Laight wrote:
> On Fri, 20 Feb 2026 11:24:45 +0000 (UTC)
> bot+bpf-ci@kernel.org wrote:
> 
> > > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > > index d1524f6f54ae..c81e0a58caf5 100644
> > > --- a/tools/lib/bpf/usdt.c
> > > +++ b/tools/lib/bpf/usdt.c  
> > 
> > [ ... ]
> > 
> > > +#if defined(__x86_64__)
> > > +static bool has_nop_combo(int fd, long off)
> > > +{
> > > +	static unsigned char nop_combo[6] = {  
> >            ^^^^^^^^^^^^^^^^^^^^^^
> > 
> > Should nop_combo be declared const? It is a read-only lookup table
> > used only in the memcmp() below.
> 
> Actually you either want 'static const unsigned char' or just 'unsigned char'.
> In either case gcc optimises away the array, the call to memcmp(), and
> just compares with 32bit and 64bit constants.

ok, makes sense, will change

> 
> > 
> > > +		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> > > +	};
> > > +	unsigned char buf[6] = {};
> 
> No need to initialise buf[];

right, thanks,
jirka


> 
> 	David
> 
> > > +
> > > +	if (pread(fd, buf, 6, off) != 6)
> > > +		return false;
> > > +	return memcmp(buf, nop_combo, 6) == 0;
> > > +}  
> > 
> > [ ... ]
> > 
> > 
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> > 
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22221513473
> > 
> > AI-authorship-score: low
> > AI-authorship-explanation: Domain-specific optimization from established BPF/tracing maintainer with iterative lore review history and deep x86_64 uprobe internals knowledge.
> > issues-found: 1
> > issue-severity-score: low
> > issue-severity-explanation: Missing const qualifier on a static read-only byte array is a minor C best practice deviation with no runtime impact.
> 
