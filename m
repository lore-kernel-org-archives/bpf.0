Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2337F019
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805053; cv=pass; b=cjerIy2ZrNVZqUEb7RIjKTCjOqkW/F9ObaQ/Xassw8fxG0w+OXYZIhXXgqKHc0FjP2o+WRPl7ZKz/T6hofAG1ET32Jp+/Q82pf3TTRdWoMM3Z+8i0dKYM7POPshX+Zp9lCMi9ym0YYT9EvaJQczllAO5HmZ64U8ioEAfR0GM/NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805053; c=relaxed/simple;
	bh=nsNcM0DY0GbrHfIl8bqyLDrxI4+ZyqV/0MjDIthQBQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBzghZSO7prIpxGuBQyrQ7/SE3U1Uox+RQ3sE1RiAsDlAqco4IarWLJsucx/wK+EXr/kSoGUOFqPCl9bZq+s0VFI+J++lJTYghKQP8eDMAOkTH8NXEJZpo0KNOoRVJNshsByu8ywS9otqRDvxYz62PmLgpYSQjoWu3xaa3EU1sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHdMV1L8; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHdMV1L8"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso357414f8f.2
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 10:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774805050; cv=none;
        d=google.com; s=arc-20240605;
        b=icD0aNJrkJh3Qjp+fVWayysAg4nfqO7TVUpoH5S3EcwvMJBWGImDMnuGIGhguVDco8
         xKHOsGFbYAXIFRLhLN5Dp8W9GaJmAByUd7+RknxdCNQrubtOXLDb0MPkH0Vci2lRi+pT
         ND5lHRknQ6bIfxHuQo8o1NNybpvBNiGTEMRCx1WY8C/12xUJp2Mb05rXjFNBu16S6K1I
         SM01MEFXB9lPlV6Ju0M9TX1opRMYctdiat3WEyJdTYMwtb5RwMA5U0HMrJ3+OHz19jBf
         vBacOGMlphdWMrpCLSTcvxBz+1rLjnnVtiqxJsd4NjdPOmU3EY2q2VcChE59eW06He1J
         i7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nsNcM0DY0GbrHfIl8bqyLDrxI4+ZyqV/0MjDIthQBQQ=;
        fh=N37MlTHBtHqxfh87phmY9ZqoZLgztWSgFg/nPGVmFfg=;
        b=aKQ1okQEJK1w9lnmokGRmOR9kPeJVCmXFAePUc5rbxpmJvQb7o39THYPi90DvxC6yy
         7dMPTmhcMecfcMCJ7H5ivadA3LoFBMkupzweBZB+47CW5I7e0pzuT5pdAsDayVtaU61d
         yKBQS2UYGm/n1o+XXKwK8RZhvLVO+O4JxB6uriNf8da8MMLHDinRlX3KHAz/+KcnfJau
         Z5BOnNtpj6i6gxBsXd+z42bQTYEVyFyttvbEWpfuDPTWbKmRDhlGnuXJBbFptL9Q89q2
         M96fNzxSu2khIAwHP5Ow3jAu5d+fb5FFnxiEaLRAwI75kEEZWuiP7ZXGBNFcb4iOEj+7
         gD0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774805050; x=1775409850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsNcM0DY0GbrHfIl8bqyLDrxI4+ZyqV/0MjDIthQBQQ=;
        b=lHdMV1L8RxLwEyQqw/PorgKiM/BJGLuDJf6RYkuUfMsz8VXhIUJnW5fj//csD5Jlx7
         LDygBNgaT9cWmm7otcsWPDAX5YBUCDiPr4na/V74owZKAuTFwhabIWM5EWVQndw5bBKY
         yKTEbma8Shbt8csZVfIFXtFwYS7vM/fPLFJc4sVdZzTUimq/8BAmr9nCduQD/bho6HKu
         JKNajYjM/JqSCXXAgA78bOjPbNelS5tuI0HY6Qn5e4fbGWGRNz8LE4QTm96hnGq2Se+y
         fSaxL7kz4wR0yKuzD9s7PeY+vZzE1k3tWKVgz1xP6ONvMiipeQnIC6EqRPzmnCLut0Z2
         XWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774805050; x=1775409850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsNcM0DY0GbrHfIl8bqyLDrxI4+ZyqV/0MjDIthQBQQ=;
        b=gWDh6jEd7l/v3UfsZDhx4xEajgkOfK4VBFYamKVhRUN6awqmWtOKrU1Q0ek+Mpw+av
         s+bmASJV8aAqObpub7b67hWIuM9Jjo2+T+z5C9D9PWuAeZAW8/oAdVSD3RulVkeVvd1D
         k0GFSy2zeXO7sm3mi/xw9wPATh618zgZUwYbWOFjbak3O83C5fGBxXEJ/EPanHuLQlFk
         xXjvDGjkxQkmFUzGoB4UvG6OOxcICEUVJgkpA8piwtMwN+zoxgixTDho3wh41zpZoSUF
         w69tXsjC8Q4HkVlgD6Gpq2vHvArJ9WERxvwHt6IfWboh7USCONfFMcIQ+IHsLilAbvNH
         wyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVlZKBx9eSYJ0VErK/i5SpMRXcJep1bqKa2um2mWbFqUiJZzpdpO217Wrd5C9TjFDrcSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYB6qN7ngwXwu8Z8dGl+uJHh0KgAkeHuVKQjGyFDC3J7XY+3Q5
	r5ESCs/1N1lr2DRapIdyvPeZ4PYgnZbO9Vmib2oXJCoFHGUYSHP3Je8u6Xf6xzMFUt3FDX18NDX
	rFw+d2Od6uFqfTWe6JOD98jwpjz2hUc6YGQ==
X-Gm-Gg: ATEYQzw9ZUToKUPog1xDCXXFtmCOGyyzqC6PKq+69OySiEO6OAX7eBhMP2PrMWorhtf
	uCG1+ENca0tX2eREYdJe8v58nFn3ktiNpWcILxncF3/+tDZ1S67Rhq6rQRkbE92XwcOE1/hTM3o
	E5r4czHk2DbBM/EzmgOl15jTQyNbikNTK5ga0EMQqUL0ZLMeDidZG4y89AnTsCFYsW3Xq92ASB2
	P6/85Pn53QSl27oP+388LihoxK91pV5cey069C+WxX4UY6sK0tt/cGuVEVFEOmcykUBK6tlKFBl
	YI5hec3hOjIEQg6kY+w+g9FiXGJxS9v44ik/5AyHD8d2zxrNBbMxbUyszPqlyw8kZ1OxI8VgKBJ
	Ac+piB/XhdHZ2ES/73xLUBioduA==
X-Received: by 2002:a5d:5f90:0:b0:43c:fdd9:1890 with SMTP id
 ffacd0b85a97d-43cfdd91a7cmr2742839f8f.51.1774805050213; Sun, 29 Mar 2026
 10:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324122703.641-1-hechushiguitu666@gmail.com>
In-Reply-To: <20260324122703.641-1-hechushiguitu666@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Mar 2026 10:23:59 -0700
X-Gm-Features: AQROBzBTRgi-yNiUamK3PL6ZySeng2gSnp7g-HgSIPKYBlYukOHbRkVG543ZXJA
Message-ID: <CAADnVQJF70sBuaJsXW+=1cR3wTQEq9zRLG3jrvg7A5+Xqiw74Q@mail.gmail.com>
Subject: Re: [PATCH] arch/arc: bpf_jit: fix missing newline in pr_err messages
To: Haoyu Lu <hechushiguitu666@gmail.com>
Cc: arc@lists.infradead.org, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 5:28=E2=80=AFAM Haoyu Lu <hechushiguitu666@gmail.co=
m> wrote:
>
> From: haoyu.lu <hechushiguitu666@gmail.com>
>
> Add missing newline to pr_err messages in arch/arc/net/bpf_jit_arcv2.c.
>
> Fixes: f122668ddcce ("ARC: Add eBPF JIT support")
> Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>

Applied to bpf-next
