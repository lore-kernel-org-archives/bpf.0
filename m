Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C124052CC
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779061; cv=pass; b=pBcXl0BZWoI4GKLxcmV3RT4gv9KtPq7uh3VeZe0uTHPHr6pWsujOfjAp5Fzt26fg1+0P2ZXXuOXs3x7IdCQf/NrXScZ04drrIbu1rH386O5iULIvQz7H/nLKBtqgZAEDO/PxOjmks1avnAOEc6zyz113+09rx0DTTOVaMj/YALA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779061; c=relaxed/simple;
	bh=9yECdm0iXUkmEtYXYxZW+9VSvxlbkQYudfihdqNVzTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7Hy5WFpbQz3AtYELA1FFmjwTZBRgFA1+UKRM+Pn8dIIHYo314D/TCUkKrVbCwapkXri4HUkaAJu/xN2pCLOrPj+QNH0TbJiizBLqEyd8qeznJHrtX8QYJ/ywCd4dHaEe8X6P7DzZ+NTs7tS1GxdGEvmxecLYiqiXgtGiFS9DHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6JamNA/; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6JamNA/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84a652535dcso2457439b3a.3
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 10:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785779060; cv=none;
        d=google.com; s=arc-20260327;
        b=JIncsbrnXt+Jnrghen81ynCIvpRFHE8OPtL2C/xQShxXyS1rgoEJJpa38XF0fSUzkJ
         EFpHgXbkUsezowbSqNs6XbRrL35/cHM4/L1vBImnaAjyomMnvxkR5hmFfWp9xYlO+oeD
         PQV41fRZuKfxulsQQ6TqC0uJ8nvt/h7FyMSB595Fo66mACjNSfgr/VjgiXG717TI9NUo
         OAX+O6blSDfa3qixTjWGG2xABLk3cCMRHjI6ywvmPvWEd/nrnhzPz6Q/HgFMPsx+dswh
         kxvEsOSH+Sh/PdlFkjnZ25hw0wC3fE5hn7R3FZKkoTYgofsBgRLpEHaBIHyWWLGnRdiN
         v87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9yECdm0iXUkmEtYXYxZW+9VSvxlbkQYudfihdqNVzTU=;
        fh=NYzz7teYkyU922Ck0nhiAsKcUU8vH6EWozaE/KScL8g=;
        b=sistcxWVItwCeJS+nEZL8G1CvIcdci4+OFf3Hw/8yABKYzX+6ViTLKpe0nsgH/Fk7g
         idyjn/x4tSJQRDOer6gKAnpfVKnHfFN5pwG+oOrmHLHKNs1V0euYLtt8QVpH32oYKYL2
         KaqaZO1yi4RYefg5zVAKMtixlt4x8DkGDs2B3GmsR6iSRjPzh2ajKpQ7ZJj+WI7xR9l8
         Mjeo6jmGulSi/3k/HwzQGtL2fPz3Ptc7qIv6AuSJBjX7jL9xuU/lyrIsn9zTX8zz6qH8
         Qpvvb8zQkaJ5S7m+45BwKVpVK+MI5r8w8d1Ec3ZDSq4Syqar/2Mt/hCFblr/NF+2iTqE
         fbHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785779060; x=1786383860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9yECdm0iXUkmEtYXYxZW+9VSvxlbkQYudfihdqNVzTU=;
        b=g6JamNA/LradG+dKR3xBfVK/Sx3rND1acSJDVGfhJpcC9Y5LKa+Ga8jRepNHuD63Bx
         eYXqN2/WrvyzupnIIRG8N/23Uqi7qm1xGWbHv4DLwbACKmxYkdx2h3mOfyQ17nfBBcG2
         dPcfNw4+vcSrT//4MAkcbZQXgEZzcoyUwiebc8BZ57UInxcz7VHiEgu10281RSynq54N
         E9i0rRhU4TbGEJIMBV6NuxvFJhR7juWrjRZ9uXQ65tCtClifiaYbhkb8gb7rhX8Y8JOm
         lg38bPVW9s/rw8ECHqtYVVINO+YZCwe2f66pCwZO/FGz3Jf36b7/lsaopwdDOfmWsWb4
         3g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785779060; x=1786383860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yECdm0iXUkmEtYXYxZW+9VSvxlbkQYudfihdqNVzTU=;
        b=NvAZ7iZbAqQYbslsARDCjG+epTvdLeBuHoO4gBcH1E9lipbXpNjwjiJOthQ2w9D+fX
         TDVdYrOxcgBzh+qsnlQAvZs3i8ONGkLHU7ThGAv7xfsejj9TQajvh4UJij866wed1t6C
         AUEZUOsN54tlK0Y1H9zRS6uCUZUTjxLPXZk2l6LzkBEnnbvcYDEazl2YLU7iSLc8KOiG
         RZmGS0CqUVCXxEgzSl+Ghc2FnyQYBAQYLAPIUQLiSuzAI5sSm3Bc2iFXDgEWQ0G5RUFk
         ENJT5eyGHvRXAhKLsYLcESbwC+9kNxKgsyZJCTeX/2mua4ZpnYRbi6F6mn6zoJPqRYM5
         LKug==
X-Forwarded-Encrypted: i=1; AHgh+Rr/1X0QeXHv0hxf9J3LkZITPMpy27f0fAV3ft2fxDJIiM2PTHkXqAE8ukpf/9W2dWDOPvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxy1SB2nxd8+IUwgKfxFKHbI2jAo7iW2fL9PIIYVjdJ5q2hIO1
	wjLgg+GCy9tn7v6PGICkTm4c/Ui+81GLHvgb3oweXVvIZnm1OQGTzbJTBG7yS70Nq/eT7pJavOE
	Br+K5WLVdMfjXco9uMJ11/vHjskZtJCc=
X-Gm-Gg: AR+sD12ldZvcd8nQlrs1Ze67tkQKcn87c2prrwqljj7ym0TLyLHYN33pL+PQ3cXJTz0
	XLSRXGTIeZh8MDakYFZNg2joiNP/LHbmnPXJgr0fx5A8RhRoGjmTBnNspwBMtiOsP7y89M3mAnD
	k2L75RxEPsa/c0Yerv7ooFlnahRyVomh5vE5QzVbl8eE24gQTrG/1JxSMStJZC1ZgnS0AYs6+Jz
	Te63Tr6mhe5DducJralFDbxAB2cIrrikd7YsktKUiTwJlvzx5WC3n/K/cUn9wuMLTfzF5aC/nPT
	YDsBIenFwBK9VMnciz8lBmQ34tYxVnDquremAlYycnK4Vrv1PDRQ8TJIOLBLCRloC4LY5dXFm8G
	twmoqP5UQh3pAzG3JaE7JjhxNw3S1pkCq1YD8GUBZKtPTDGdtNHs4
X-Received: by 2002:a05:6a00:856:b0:845:c8f9:6ce0 with SMTP id
 d2e1a72fcca58-84ee485a40bmr9631982b3a.21.1785779059899; Mon, 03 Aug 2026
 10:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZ3TN4b0OFOV62YG=W3pAKD4x2eK=_mrmBCci7=fNQE0g@mail.gmail.com>
 <20260803094434.2763945-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260803094434.2763945-2-sanghyun.park.cnu@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Aug 2026 10:44:04 -0700
X-Gm-Features: AUfX_mxFydJFsr8HIbVCpTe1SW79Cz07GKdZCSbYbw1_ImBI2IxBib4mGym2g3o
Message-ID: <CAEf4BzZ703vZPOFobvSLskKA2DzQXpMcDd1jEaydGEwjx6O+sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix mmap_lock leak in irq_work path
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 2:44=E2=80=AFAM Sanghyun Park
<sanghyun.park.cnu@gmail.com> wrote:
>
> > maybe we should make bpf_mmap_unlock_get_irq_work() return `struct
> > mmap_unlock_irq_work *` which would be ERR_PTR(), and return
> > ERR_PTR(-EBUSY) if (active || irq_work_is_busy) (see below)? I'd
> > probably call it bpf_mmap_unlock_guard_get(), though. And then we will
> > have bpf_mmap_unlock_guard_put() (instead of
> > bpf_mmap_unlock_put_irq_work) with the same logic.
>
> Yes, I think this would make the code a bit more straightforward.
>
> > we drop active to zero here, but irq_work_is_busy() can still return
> > true, I think we do need to check both
>
> Yes, BUSY can still be set after active is cleared. However, since the wo=
rk can
> be queued again while the callback is still running, I thought active alo=
ne was
> enough. I also tested it in a widened window, and didn't see a lock leak.
>
> But I may be missing something. Could requeueing the work here cause a pr=
oblem,
> or is this mainly to keep the original -EBUSY behavior?

I'm just not sure that re-queueing works if irq_work_is_busy() returns
true, please double check. If that doesn't work, then we can miss the
irq_work callback, which would be bad.
