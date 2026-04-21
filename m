Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038DA36B05C
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776741539; cv=pass; b=PVktAONg/1XBHpOf/PRrsr6iJ225rFZSNS8CQKB//L3JEobIhxDo7Cu/KahduhPS8Sj7ifU1traE1C8dTpFTNq2ag8oMtSDLZn4Gpw0cIEiCHsEefYLKwI9C2eLkshcgXWYyPzqIMsXLVljGgvmFnyH6jjmfIL/ru63yAqzLSf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776741539; c=relaxed/simple;
	bh=oAQFOLETOC55mHFL9QLeklvJf1zkdvWXYASdKSoLlp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBKNMX3S0tqJsgN7VREcnhCnPIgRCxqvRggWLoTJWH0lxq4cwWDamWP2QUSM7Sni5U2B9S+33zX7pTXiLkWWFBM5ZSd5kYJ7/yMctjxNxjiZZJ6qRl6mXv6OPLs5wKlrFrYHVSrcOWKxrhPgmn5Yg6fFPxXIqh1ym8nF+5jf2N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHSuD4zX; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHSuD4zX"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56d9ed609d2so1138790e0c.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 20:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776741537; cv=none;
        d=google.com; s=arc-20240605;
        b=DMr3rtmfqT6kzrMZcf8ELYgdsJpziVrwHYbCFw1mHyDFI3ukufSTtXmbRySqnLwPc0
         My72QlOUFofds53n75IsSUudDwyDVTNBL2CEaxAXjX82/Anx/mreD8G6Mgx4veG2g9k/
         L7jHlXSburPpQTXiCXRO8cp7Awuyi4yfCTpS2a8dF/nlh8+fMvFFhTD5PsqqcRqyP4At
         2FoJoEjgtJVjzRpYkT7cW3YZplChz1Z6YUmqNPbcmD4QTasZl1nVgSo/6nHwist1KubA
         Pjaceekey58nGJYN5f9cqv1X9TXL74vP3jtllmjJ+I68lYffpHUrDmhGDVyT3gGjqVj9
         eJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oAQFOLETOC55mHFL9QLeklvJf1zkdvWXYASdKSoLlp4=;
        fh=ypw/5fet4CANHeQUz+kfgabEvSoH35hHHOlcI8B0sBI=;
        b=FK6WBLH/S6FjaTu7RB82S+lTWutOeuvsSkAlFCh2uK9NDVa1vdQRy0muQ752vMaf6L
         Q4FgYIMcWthLYBdGm4wTgPOcKMv4IFKwIy/1wqZXxBqdCm41ISKKSsvJ5wuUAHAmtNrp
         n+ZJK3WlidvbNNJv4f7cgtMeTb4vHLlnjfm2xigUWwrABGf5zg46YXSfK4lDbOxkzTCR
         IAnn0g/cJ5fJUkmSvIFyVnPvLTXCVlEnUycAKRpbQWIia1pkPMfW/Am/H/p0wOLCdCCi
         EU3P4i+59vwbwBFgtxYaufOePv90em5GDrywBfgkUTix6WrIewXzSGqIZx1FbeqQNvPQ
         x3CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776741537; x=1777346337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAQFOLETOC55mHFL9QLeklvJf1zkdvWXYASdKSoLlp4=;
        b=PHSuD4zXDnAZ6qQkbis1SKoO+OHPxCF6375QwEJPJJYoGYCRm5VCG14LQIRCfFtfCz
         O1fYHqTrvatRg58PR+T4caio/29NJ+zJbPskgZahdHLVszBmmbOvh5Pq2Fh6Zs9HgaDM
         iLJVq2DeQSDfPZDYL/PD+Dby9CUnV9ulGhfVVtg1zqTdFCo3dR0aFs7kO0Ci8KZICjTd
         nOTsAJoZK8DjnUoSv22KpYqF5AiFhLEUyjAmAxXaKxepuAaIjENTQIuDwuf0Ii+z9bDH
         SKFVuC81QpRMv5zb2Fyapj3LxEkTSci8MH1p657Z9lAaHGllU/Wmw8vllmPnfcTrkr7Y
         eAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776741537; x=1777346337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAQFOLETOC55mHFL9QLeklvJf1zkdvWXYASdKSoLlp4=;
        b=TsIPPL10lTCRoehVMBntFjCXCMVYFUsHN8WT2gKnDy9jyIk4v059abjlh5vNp6NVll
         gAUV8yYIwLqmOriKjKl4cpDVBi5Dr0klCkY93WD/uY1JMDNQODZ9/RHgoSLXAoiGv6v6
         Xv5boGYy6k+vbI/APKzo/LkInDMrxazz09MDieTiemYfXKRRaBOtzrDmv93EYzRwBr98
         B6kX56pzbRTCLhklJi+na4UBJdJBeFAKmsDpKCOGCaT+BvdoRwzYVE0xWfnB0mdebc/3
         yzeIWJRYGyRmGeZAYR6ShARmowm2isBmN1xVtLlaVRA2diUTpvCMCjaCKCH6cPb3BIVZ
         MPhw==
X-Gm-Message-State: AOJu0YxBDfhWIDkE5lIZbJ55rVNR/A3Nc6DzVTxzsccO61/2OXjnGfEV
	mn893Hql5quGDoRoPB8HuNV+4EmgQ05Ods0sUjBM2WABFn9qCqBH/d+uGQzUaHrBnC/jtrKywdg
	l4EtvAJPV7KoYlasyrYyy2mwphTMw74s=
X-Gm-Gg: AeBDievCWf4fSwCIMawuCTE5qTu7xKsCP2Gpfrfek0xwcvuxqeEt6tzyQAjruD/34W3
	920UirwzPpfLUD7qk7ibaTMRgh3vInCZfAC7bwHBfAajZ8iJpE6YGDAGJCkTrKNCtMktY3qD5ca
	XejowWlWL10gaGsRO0lnAgSF6Jos0oE3FLSSPISH9LbsvhyK/4ANlWswTaQufSgJplUHjEzD+rz
	FBjG5wjl56sOU68/2fv22+YEswKvmBXdBIFpLIB9TAWQG47E5vqmfVqiCASpcbkQHjtq3lMc2p8
	/8XCNp4oib07MV4zJYhvI72KK5fq05yDgfaYN7DCpLfj3RnVVJ0=
X-Received: by 2002:a05:6102:5e8e:b0:607:4fe2:a644 with SMTP id
 ada2fe7eead31-616f53a9fa4mr7009556137.6.1776741536905; Mon, 20 Apr 2026
 20:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
 <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
 <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
 <ea37be7028d20e962816ff10631da383b5910c57.camel@gmail.com>
 <CAM=Ch04tB7sXD_qmK-5NZ-aQZutJ6bYmciU+hzZZ8yJx-hbwLg@mail.gmail.com>
 <aa9704461f816bb90e2648d7ed2ed40268d63215.camel@gmail.com>
 <CAM=Ch079=-6advVJAaEv8U5-N3_nZY39qf_5c7s0krU02oEa7A@mail.gmail.com> <b44b4b9333cc099882c919145306381ab01d747c.camel@gmail.com>
In-Reply-To: <b44b4b9333cc099882c919145306381ab01d747c.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Mon, 20 Apr 2026 23:18:40 -0400
X-Gm-Features: AQROBzDECqPR3IJACn7fXZxXXFkFSnkD_HP-D64hyS3E_pSj70H6bR232T2bFmE
Message-ID: <CAM=Ch04iBjc9ide+6i4hrE4guL=bp0P3_EshyjuFb9QnHkaeGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 6:41=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2026-04-20 at 18:35 -0400, Harishankar Vishwanathan wrote:
> > On Fri, Apr 17, 2026 at 8:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Fri, 2026-04-17 at 20:38 -0400, Harishankar Vishwanathan wrote:
> > > > On Fri, Apr 17, 2026 at 7:19=E2=80=AFPM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> > > > >
> > > > > On Fri, 2026-04-17 at 14:17 -0700, Eduard Zingerman wrote:
> > > > > > On Fri, 2026-04-17 at 01:34 -0400, Harishankar Vishwanathan wro=
te:
> > > > > >
[...]
> >
> > > Tbh, my version looks a bit shorter/simpler.
> >
> > Agree yours is shorter. But I found the individual
> > computations in my implementation easier to follow.
>
> find_witness_aux() might be a bit packed, but I like the successive
> subdivision into cases more than ranges accumulation into array.

Got it. I'll try to see if I can combine the best of both ideas in my v2.

[...]
> > I can follow up with a v2, which includes ideas from both, probably clo=
ser
> > to your version.
>
> Sure, please follow-up.

Yes, sure thing. Just a heads-up that I plan to do this by next week. Thank=
s!
