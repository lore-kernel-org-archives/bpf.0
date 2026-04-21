Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB550284693
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798862; cv=pass; b=JFk5R41P40ayuKtK89/gnyEDacRf/CX/Ce5DlHBkFDsWawesGMnBxq0AAGCCopQEwJGnSTLuh78UNC7nqXoJmPMuCCgvDtpBthrOx/EVSDC5oidtnFhNHCkOqj4CgVOMJsKaDS9vhKPHcVL8FC6Jrrh4azXv6eaPC94UKAt19yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798862; c=relaxed/simple;
	bh=vdgE8kA4HbCB/vOl08y8ppNFCyhCXUWAqC7obAYsbO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apUXZTZIZq0t29KwenaCvIOC1AO8C8yIQv4WvUbPQ6BY9+ckmCKlEdei39dC/g7cnWZ1H/41QRJlHl3Ev5mmDXttMqQ0kM5LvKBY0WUkKa/L07DlSzNpG5pWNXJcFlIaia1V5NMoYMoYN2pqEgk5LprxQk/78+/VEnNK/oWjucU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIMpSbrZ; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIMpSbrZ"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so58558335e9.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 12:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776798859; cv=none;
        d=google.com; s=arc-20240605;
        b=SJrAz7rkx3GnFKAp1THGFnvNqVLfM4/Lz/YVkcnStg1aOUZwK74l1tSEfDq3IdAtKv
         nY/zZKBQbO09Q58uCAib70+RPNdRrldFqoiDh2HCQFns3royiqpLlg4ffI38X6lR9tKd
         DVPQXyFxY9tq2Y/eW8IL51o1ZA7fym1peclDk9teBAPoPfHeHE1Ss4U+2ENhRsdAgTOC
         ZJ8LNcYc1HFiey3RvpLCPkVvt0FWGPpHwIDoJAe+dGEznth/+u5dPPC/zuu7V7VJY29c
         OTX3FwzNvPEJwwyuarZcqJ9B2vc9eRyl3CHbCqxputaR3WBcVlB57TUPFUjiHy+hqGDu
         oIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8QuIbpmmSDmAbmPC11YMTkT11Y9iFNyls3uv9pOhJXQ=;
        fh=PvYPcwWkAFTdNDlHuRMEXK4H0X8YFjGgiYsXgOFIKvA=;
        b=IYjOmTSs9cPfpNJmWcQ9dpHa9enyg58eBKmLApq3oSsp8FRcBIUmUSR3ieO+XZldaW
         /HvKdM+BKXIWFNwOIVeLN46mh1o7Ha9ghXiW7YLqg9soxGtn++6iEhf2613udYg6/duU
         HJD6aurqACrinfSQ3B8qwwpYiNnsswIXY6O8KzaByOh4sYXGo1PxJSYtBu3h0/FCFo/E
         MrN8BPC4KWCWQ5siXDHaeVHcPlzFAnyMIEhCCcdMnQlvTu/ikHK4O13mvI3QdPVJ86pU
         v/PpYFRj/H/uAMlbjLbrVQfn/QTGP0DwbKuqRlcvX7nECF+A7dnM6hrReBDeV6hGYMDH
         Ajfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776798859; x=1777403659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QuIbpmmSDmAbmPC11YMTkT11Y9iFNyls3uv9pOhJXQ=;
        b=JIMpSbrZJqjwotMuAqzCwOzZf8BIgUZsk0lawEFpT42mVgi5QWu/e0km4Q0tJN3C40
         cLjYXlAS1ltxQWEQsrRXTKLI7EIG58sM+lwdvU7uy/XoxFcjbarHCX0kjYVIj54OR/xQ
         gbzvfCkZ+fSzKugaTdRuLNH9Z9RFCjrcl2CODaT0NUcEJjzNh3Jo6Z6O2hbpI8vQq16S
         BYaH1AsmqoinTjOJaIBH5Coh+bdLBXnGTTQiHpSNVHVA05kGQgVrgQjR0aK+20velBpZ
         aHVYteKoQYrtM7dkAEdnQY7VLDaM2U9Pd6NTAWHJZzh7w62A+QrmjirOwNxXBZQ+1j4g
         nsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798859; x=1777403659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QuIbpmmSDmAbmPC11YMTkT11Y9iFNyls3uv9pOhJXQ=;
        b=n4V5th6K2lB5W3auM8p2kyyCNZmXx9dAjE9LZ52Ou7oFt3bozZim0fc5uP9ZoriI2E
         xu+pKFaVhXUK5A5aJzBu8w0X+qMbddBe2fi8LyDBc7wRZZs1028jmp0KtKkPtIHEJB1H
         7l+sc+xASv/TqjPM2l9mmKL2vcP9Y+fRNDvrdZow2RDbZzJMfZz3/cqIqjw4JNOtJS2j
         291JUp1x8uqo9YGJIUP8jO3si/WEbltpfFofTSN0JawYSV9IOpAw66xbAUbH0kEUGOR3
         h2QF9n2h4WmFL5JKlTjWXsjTAUO/FCSlAoQTGPkRPwP9Y3hxjZH8+iW+MF/GsrF1MF9s
         SeNQ==
X-Gm-Message-State: AOJu0Yx265qh0TT7JPWJWFLnobEo+8h+1P7HUw7BZ6gRUmv+lRFGYijM
	plOGLO6w5puMyLDY1lfb+deIEglK8B73xOZ2BwqaaNU9dJiIVX7kdbZqKjMN4MjcFlL1LtAzM5G
	FrhF9IaXGZdPucg1UZR+kQ+Tq+urKES0=
X-Gm-Gg: AeBDiesMnoVmy53JmYAqmE2Sbwk72Dr6o454Eq7QoqkLTzzNO5sUwlbtHRn4+tIqoTt
	EnMXv9FHBtUwZOHDL6GafSJtbkZYMESrTca4fr3jg+OfPZzoOY/K056lrDTOXHQIHeGnhqincB4
	t/2jzuhnD7MvkFxihw0/chPxXaP+XR2PicV+wulzWlW0W2H3is5zoBVcj1gxP4uwWtmr6ZqF+xg
	9rNKw+HC9gwATF71ZHKaft76oeUhUmDzMj2zoWsI6cHLiCvh1yPysRnEG4xC4vaskU7cJhgNFNL
	wAuSZ8dRkSu76MfbE3cAyaNRkWfMAWnPmF353hPiwrFp0vu52zDFmi8gs7ifaYh7TrPqz+E2G/k
	1QHHEGwhZ8wHINZNoRu4WoFwpLOFo9vc6oMyJQ9joy1kQ+hgy7fVu6k8MjNiHbbS0zEo=
X-Received: by 2002:a05:600c:c4ab:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488fb7864c3mr280263825e9.22.1776798858977; Tue, 21 Apr 2026
 12:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
In-Reply-To: <20260421171927.3507554-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 21 Apr 2026 21:13:42 +0200
X-Gm-Features: AQROBzD4pEU8Ii2JF-Mb3pXU4nsGyQqLTtwIVsb17l2eWwj1IZU9P1zcPXzVvJ0
Message-ID: <CAP01T77n_5z5v8LHPjwqJq+5O8ewZZ42diw4thr59ycR3VkUMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/9] bpf: Prepare to support stack arguments
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 19:22, Yonghong Song <yonghong.song@linux.dev> wrote:
>
> The patch set prepares to support stack arguments for bpf functions
> and kfunc's. The major changes include:
>   - Avoid redundant calculation of bpf_reg_state. For stack
>     arguments, there exists no corresponding register number.
>   - Refactor check_kfunc_mem_size_reg() to have bpf_reg_state's
>     for both mem_reg and size_reg.
>   - Allow verifier logs to print stack arguments if there is no
>     corresponding register.
>
> Please see individual patches for details.

For the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
