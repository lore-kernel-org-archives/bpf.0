Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A8366DAE
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632745; cv=pass; b=DIzjkpsuNvUZb05R0cc+rrho52JzBKtXzqKPnk7K8hp9anbtIScH5eKowqWp3E7eC5WoPmklowXOmvN4wkSGcKwSXUK0WwLBig+Z/XLjC54eteNZVlAJfeH2pG7vC0EPpwH7lEthRZatqDK++7IorIKB29dGBtEcZKNfGcgWXgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632745; c=relaxed/simple;
	bh=jJ7Ja3pq8GlBQQ3yJIz4WpWIK3mpfgNIH8F/1c40ZSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJqUEO450WnTMR6wAPONxrNcfEG9acAVxwSoAOKI8+emfuE5dNm5Y4F27VvdhXpy4hQrRqQ/57OynKGdpML06IevDp1X7YUjgTVr6zRUfLsVFk8PCHFORFA/+Z/ESeyxeJqZquFrmBE7D0BVlkfzJo0eVbQkqGrIvO3eLgOhmTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYZHI3PM; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYZHI3PM"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c6f21c2d81so440090985a.2
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 02:25:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770632744; cv=none;
        d=google.com; s=arc-20240605;
        b=QHb1VbllCHjAsJtuEXHJjTPt0ymoL7v15KffE4H6aDL8Mfng32f4cR9Hs1TK8bhS6D
         t7Gqw3QFBSmV5h3y8ZNlkc6vvJrEVIxK6tEmRWJyJSTjsGh+fzvpGKU/dSKCAxtMirDQ
         HVrz1rTDcL9ihLhL2mlnQqb5hoxHROiLUeXVZrTB+p9B8TdjBQQSXLXLuD5tJi8a0WM8
         B/ovnymZS+DCEDb49++L0nGhCRkdXT75KONBON3WLjwaGkC6M7lOPKm9FCDqXcOMJgsf
         VnSq2WhMuYXGf15jiBxO5ovOKDFqlwIvFa5Grxbuvwo9MnYJ31ExfwOH+zIngZipSt/W
         CHcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJ7Ja3pq8GlBQQ3yJIz4WpWIK3mpfgNIH8F/1c40ZSw=;
        fh=Kko+JlotkEleOvcqsF6upl/A3kmr+8pW2fTFvlsCnzo=;
        b=S/J+jCmChzMP4lJjGPWxgz2TSeOB9PrLNAzF41sWI8BzsAH0HdaI/d5cwIhLgJN+Uw
         rptUzXyGP/h9ZckhulbCoVIcocyk3HpAPaFLPWqN5me2lA5gXHIVppgmO2u9NLleSIBC
         1fuI5geOJpKYyAKsKuSGpCXIP8tfexi2qHVJoSdT1VHBQLs2xhiaV/1edh5ttgZP/Tal
         J6RvfpvFuaH6zSIJ66PYAXuitEqTlVI57kH0BG9wG8ecl/SzXeghxpF6HONKssE0/z91
         xzDmFxble8cxWO30iYAh3yy59zUBqr48usJArZQxtPpZO3xt9+KVN+YIY/Fjlr795cFt
         YREA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770632744; x=1771237544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ7Ja3pq8GlBQQ3yJIz4WpWIK3mpfgNIH8F/1c40ZSw=;
        b=MYZHI3PMILq5HL8PDZP5ejZGrQEI5ZK7N6CKav/oTjC7LVP+Gk9Lr2lpw/MNQEcK1I
         kde/JoChO2oHEmDHadQZJuTmgES9h4mZizkWvytpbxT8+6Z0vbAaT95FnSlmsk5ntMu2
         br+jBWBw6h8FcCIx7/mibxr9FtezEPa5+s+qlP0fqZUKIbFLIWVxA+n4PmuwfRuuqbFL
         /GzdNghfTi/5vzO7zF9zyOQVDWNnebux7hLdMxQ1dSNAo8wADj7XMzDdmdrAmPDF5J0m
         RZTRk4GHoKNk/DrQ4CZ8S2Esj9SEy4Tn3gChwqrD6LpvAktx5JI5LLxBHA4i5FwGXCti
         Euiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770632744; x=1771237544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJ7Ja3pq8GlBQQ3yJIz4WpWIK3mpfgNIH8F/1c40ZSw=;
        b=KTf46q0qmYV3itVfSC8wD35IOLp3lPXQ4WYhxw0s5aocdLprMTq9Lwj1Evx1Lodws4
         gwmMSZZjlzd4+V65N2si+QjH7ldmzzxZ/SEmJkDw5JO8Br1CSbEuY+B9XlQYIdOQeT9i
         V4eY19/rIyZmMRFzADUgR6HA/Y0fgy+M6R/6WphGsN5XDc+Bi+s81Nj9ljDycXXEbOHS
         1CKPKmNZWy+X1lDBQGB2MzElAEDgPbRMnlMZl4ez5RIYt7RQ+Bp9Q81j4RoF7ygZBh0u
         N8RNMdr9BnudCwqFNxy9P/nZYISAbwR50wffSkdUsn8pEEOHY1eYuLlB94HjJOGfT7sl
         ka8w==
X-Forwarded-Encrypted: i=1; AJvYcCWzNYi1SzGnT9EFma4nzZ5OwBCDcGXiTz4Sngl1fcwxy2Mq8Lf+GnsgnEWg77S3s7Fb3Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBHEX5Bbbqd66KcsXO0lHM+XGL80xQN0z4raNM8eiU5v/85Egp
	dOGhiYvlPpCOhur/M10fLaKTMXltX9tobASrLOaeywGFj46NiccKwRYIZyRWmk3GseiqoxlZnoA
	GIjLF91NaFfjgBrsX6eAyQtocZaY2NJ4=
X-Gm-Gg: AZuq6aIgQwbalianFmqV1kuju+my0l+Bymlumj4/mj37pCrj2kCqgEnFY+kd0orfDol
	3L5aG2a9dWWGJ/Y1ogGLrO1X8Y5Cm+lPeyLZ1xHQ8Cc3XrzoZ075d12IrbvdOdHfi2m1cyotXxS
	yZ/RYyySQIdBF2HqI+Hn54cRhfL74thUlpF1vMK9k6Q0pdDZ1FNdF6N7xGZ7h5U2C/LpmN1p/WQ
	nZvR+C9O3IpwlhKSO7t/9BfUrxqbjH5N8892hUF0ye+CVmoNIMPF73O3C0hYHX9c1xlFw==
X-Received: by 2002:a05:620a:2a14:b0:8ca:7b14:16d2 with SMTP id
 af79cd13be357-8caf1acb32fmr1351403485a.50.1770632743882; Mon, 09 Feb 2026
 02:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
In-Reply-To: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 9 Feb 2026 18:25:31 +0800
X-Gm-Features: AZwV_Qhl0qsSwOQgOMCI7xSnmG-ncwg_fyRrIRycUWmzs6NMP7bdVr-wUKZ6eRc
Message-ID: <CAGsJ_4wgG6-FvDbLw4De0r_vPO1fTH_69A2VyntabmS6H5ZM8Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	Viacheslav Dubeyko <vdubeyko@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 3:40=E2=80=AFAM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> Hello,
>
[...]
>
> The continuous learning model can be adopted during training phase.
> It implies that kernel subsystem can receive ML model recommendations
> even during training phase. ML model proxy on kernel side can estimate
> the current kernel subsystem state, tries to apply the ML model
> recommendations, and estimate the efficiency of applied recommendations.
> Generally speaking, ML model proxy on kernel side can consider several
> modes of interaction with ML model recommendations: (1) emergency mode,
> (2) learning mode, (3) collaboration mode, (4) recommendation mode.
> The emergency mode is the mode when kernel subsystem is in critical state
> and it is required to work as efficient as possible without capability of
> involving the ML model recommendations (for example, ML model
> recommendations are completely inadequate or load is very high).
> The learning mode implies that kernel subsystem can try to apply
> the ML model recommendations for some operations with the goal of
> estimation the maturity of ML model. Also, ML model proxy can degrade
> the mode to learning state if ML model recommendations becomes inefficien=
t.
> The collaboration mode has the goal of using ML recommendations in
> 50% of operations with the goal of achieving mature state of ML model.
> And, finally, ML model proxy can convert kernel subsystem in recommendati=
on
> mode if ML model is mature enough and efficiency of applying
> the ML recommendations is higher than using human-made algorithms.

Hi Slava,

Do we have any concrete examples where an ML-based proxy,
together with its userspace ML agent, has demonstrated
measurable performance improvements over well-designed,
human-crafted kernel algorithms?

Such examples could be in scheduling, filesystem I/O, or memory
reclamation and readahead. I think having a real, data-backed
example would be much more helpful for this discussion than
reasoning about an abstract framework without a concrete use
case.

Thanks,
Barry
