Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF943F660F
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724539; cv=none; b=niqP11Fpno8dHtc0hGDe/NjwI15Ge82BwvW8oFEKMLMuwgCdPrq6mxQPA077xA6kYH6lRN4TZSMMnduPtJrE0iSLd5C/e4PMmjBPSiOFGoe4eyIGat507D9Bn4A6mvk6U40/QwfYcWMACq5fdISU6Lgx79d/ppOK8LccLo7UXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724539; c=relaxed/simple;
	bh=6FvgzDHZpkH+wHBQ6M+9btxDzY1Bu97pwScmuQYkvX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbYsr8Eh+ysPTAg4YSjdI+XDlLqoj1/0mvx5xfUJ27XCjZHxBNYjXKZTL3Vw8muoWM8+A/NXfytV/gnU354ePSTLtAYq3Dj0+eMUb0Yjjg87j6oGCLNcN9T1HkmE8K4rJ3/Md2H1NeIqz+fZqSYZ28CPMjpFa2vjXyifjcuBKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7MGTXu5; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7MGTXu5"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4ad9so3264845e9.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789724536; x=1790329336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wMNR5Izxj2LfNTpQ3gSEkUZSgr2NTSecsT1VokLfdOY=;
        b=m7MGTXu5rtbm/0kz2hA6ufJWEmMtZwME9aOCAc4cjnlW/DS9ItPqwVoLC3206DtKWT
         IFhO/rJG4n1m6M04E0BrBKaWgN0saQaoqQ6YxiBynYjtEhsXkEllxmwk+fYiTpqxSmVq
         T5eGF5gU+wdiTG2E+M53zisY3xKsbLyYFIlBBM8rc6lZl38AU7r3Dm3f2leZSomfA1YW
         gMD/Df5GYcSQDNyKDKaTcnGA6IasrEyrRvwdYT6ZgLCvygvs/ZmMKedQVUalfMy77pGp
         D5zRbBMP91jwKrDk0iK/vqkDWzpHU+h8EPZ3MF96BVclq8OPs65rgl/U+Bw4HIVexzoo
         G+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789724536; x=1790329336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wMNR5Izxj2LfNTpQ3gSEkUZSgr2NTSecsT1VokLfdOY=;
        b=Xe9HuNLTTU4DplwhyN0HSqOU6cKf2zzAvqQ/J/AV+eWM3bOcF53qUm/tZaDWOX6bpn
         1RvMGrw2K3zDrznjNCPkT/DI5/VmlxStbXBsWaB1xbQVphuUP/SoSq0dc5S9J26IIqxQ
         LwrhyKF5I1UKRDlL70GDryUrs8+O81MOr9fu29HWtXU7Mgbmek9cKbX+B8yLzlacP+7y
         Tbt9oUJFijkwAMtR3FH2RLG5liiOv3Sy7QHz27bBLuiTAIxOYgaPBcm0YyR04fs3YLGN
         /seC4EXVoR/s6D1x4w+5qVKgwpuDk1NNTt/ko4wfMtPj3BDnbNdmhERXShvxSB1e5wDr
         HJ8A==
X-Gm-Message-State: AFuF++nE6P0ZICW8o5XqWxVoHzhW/wdSmZDWUxgvyPVlUHvJA0bCaVSe
	wq49Ai55/CJNPeueD9MGSFiDGsPVerztEBE4g3MZd4HM2RHQGs8copUt
X-Gm-Gg: AYBFou1jVCd3mwr69jt+bjJkoKY7KW9dYRNQB1qKzAJc0WbPF8pSSM1YB3FtB4k+79Z
	pC5e56J1YoB+qJw3JCLPo95cQ5yr04iStTOo1hRjvw26gcOaFUluoj07Iv3IBWIzE9/2kXo/6kE
	GHH+xlqnFM3O5gh/4qM2ckcc704jo6j7vzllumwknZTo6orzp8xjuCX955u2Mq7h+FIAH47+3c1
	G9vTiCbTu/GdAdampl4V0trJU2zvo6a2T8RujdLGFkgCxFkubGw0MHuvaXXPrFrApjaTBVRV7CQ
	vC0+Tv6O1/lpUC4b7FdBVg+EJubrSce1t39u0c5uoCoT7o5YUhwbDgCuFaAkeBbbOiuPp//fBFm
	djoQO21WOIn/We2AprpDoIkNLW5PVjaDYWXhsnbcFG876kUwXM4c8qbbJBoAcW9kcJGZQYwVScn
	ERX3BnNMS/ny8+tr+F8RfHyAirRVP04KQ9UwykS6+V4kNFYHvbYvZV1jK5kUHoG4DkJDpDE3ebT
	ZP6L9sU2VfXYU4WowF0JfVXqPLDjfITR4K6
X-Received: by 2002:a05:600c:1e24:b0:49c:fc6e:a3d2 with SMTP id 5b1f17b1804b1-49fc574f74bmr22304835e9.17.1789724536597;
        Fri, 18 Sep 2026 02:42:16 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcab7e333sm19179515e9.7.2026.09.18.02.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:42:16 -0700 (PDT)
Date: Fri, 18 Sep 2026 11:42:13 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 19/23] bpf: Consolidate function call
 pkt_access validation
Message-ID: <aq0Hdd0M_6sq2dEC@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
 <20260911220415.1396439-20-ameryhung@gmail.com>
 <aqkhifLvyAhw66jg@gmail.com>
 <CAMB2axNCx-+HJVuOmS9hXAidXc0yQgv_+zAfzSkNdDXOZtFP5Q@mail.gmail.com>
 <CAMB2axPL9c+XAVP0M5ED5UNgt9CDyi2POXkUPHvikt7fPWmovA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axPL9c+XAVP0M5ED5UNgt9CDyi2POXkUPHvikt7fPWmovA@mail.gmail.com>

On Wed, Sep 16, 2026 at 12:48:01PM -0700, Amery Hung wrote:
> Hi, one question I have: Even before my patch, the verifier only
> allowed one byte of access based on arg btf (char *data_start here).
> What do you do with that single byte of packet data?

Hey, we were just using it to compute offsets and sizes within that
parsing function. That's why it was not a big change for us to fix this
anyway.

Thanks for the responses on this btw!

> 
>         __attribute__((noinline)) int
>         parse_something(struct __sk_buff *skb, __u16 off, char *data_start, ...)
> 
> On Tue, Sep 15, 2026 at 3:32 PM Amery Hung <ameryhung@gmail.com> wrote:
> >
> > On Tue, Sep 15, 2026 at 3:44 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> > >

[...]
