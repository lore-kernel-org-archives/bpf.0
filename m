Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D6360EE2
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788730091; cv=pass; b=MnMcoyr1cyNUWW5S8qiSNdrI8G0nzgAYFttdn9JgNZMqNMECl4AmUDppx+Qxiz7gMy+vPAU3p3obgdxKJTeJnZKpRGMaV9/Hx3X5ojwhIah0B7bXNygAJZlouBlkXL4A6siFf3R2i1rfrXd1aC5C0pXxbISPl6Mr9YnbL5amfVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788730091; c=relaxed/simple;
	bh=JNL1Hi83Gfi4VLq7/UZiKhBZw5BLa4CanROgvJ4RCUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7cURhyULT1ACcKgR3rtI2Wmcrlo/2YHbcirGw2rl9fAMQQvrV7HdnzprEGaEEeahGtA//NcECq2+w5I/Rx9WIFdfjXF7SW6NftpmSwTOE3yZiiLAFR2j5SXxiJKeJXt4V4gf/HoF4zWSheYrvMj6Zeb5BffFHelvE+sGVcVuqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RV4TBfRZ; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV4TBfRZ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-863c229c3adso863363b3a.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 14:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788730089; cv=none;
        d=google.com; s=arc-20260327;
        b=sKckRJadCbWTXdTMyq1P1xGsJOI0CQOpRe7YnHfiKDe1Vc1FtV8RuxYuTThQeq82RA
         TBARf/2F0FR+OWuFfylt82CnZIbWZ6LQWc6bnaKfrn/jRy+HwMzMmUL9idfNb4/PTHJn
         Rlgc7zvvEOUifapjH5HdJd4RcJAq6pJiK1ZlLtrikxuqHo+tYr9br5A917qLpToNIRq2
         QPzvnkRcx/XTPqwgNA6Nczh4UFHY3psS8w8DyZHRTUmQWRpPWjzAOKaSEpwlLJmpjIeU
         m2cQAZO/fa7dIDG7DiGdJDIWLqXfRRA0VnFJqfjaHY8wpHZGEG6JZ4hXY/CCzkdNlAAS
         ZEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2QFCcOK1H33fcWWj4EUDq7nl1+88B+9dXT9y3A7VyfY=;
        fh=sSEwiWOWpzQ8rPe8Yo/OSIlV/cG6KvizYhMaKthrZ3k=;
        b=SvOhp5naLPISBPK+BLGgBa56MTwPtPZePoj1yCRWZ1B6g951cIkDY/PqDoSicO48a0
         FcBbYPmwSVlXJevmVQtgQ70KvxRu2CMo/c2kCLpzut5nTjWB3hAb1MPhVVLZGjqGH1ni
         GLnKMMaEopRkt7rZx1njnA1A6L7L+/Qy3ZUpEfMAlooaYsR9PDQFyxvDeFqfzM385mOK
         AofPeGV7tBgJq5RbCrjONWKyB+r3wFJuL8tWKERinplaxvzTkzwgROf01gNjBnmjd1IP
         2B1U7SsQwsARzfXeha2ByYD21OjgBp1k3/m42mwaEEKWrB24EJbdnhvmXvtUYewWM5Jg
         G4yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788730089; x=1789334889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2QFCcOK1H33fcWWj4EUDq7nl1+88B+9dXT9y3A7VyfY=;
        b=RV4TBfRZdmy1gWMR0BiCBtmOLSz+td92Z0dQXfzVm9nB3wvgvyGEF/hN75F3aIyGj6
         ttUVe+wFzfbAX7lu0H/4HjHKrEzBLl1QJIbnjlTmJzupcSrI9k4ddzyoV6wTjo4sFw9M
         GX4v8dAECH0QEDFgZTeDL+/QF7iz12P3I2Ic5GbqRympz1Og/d/aqMHVNix3lE07POi3
         2rO63mhxkxtraF1JgDHgGNKEPHzwmXG+7qyG1DGJlkhEDyVughIa6q5okqKGKSc41Mdi
         CGVj4IWjd/r2VliJZtA9+L4rHfplktL57NsksQ0cVbrxUibtdhStCabrOmmd2rYhzqze
         S9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788730089; x=1789334889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2QFCcOK1H33fcWWj4EUDq7nl1+88B+9dXT9y3A7VyfY=;
        b=g8Ut+hX/o5p152bAd2L4Q0ivHbg2YOl+e8tvewttsuejhbFdBfC5zQoTQ4WNPExSDy
         44/hdIByMbMZmJ4ZvftT16QZ560xYPT46HMGRSqTQ1bU7jtkvV0PXGf2ecl2/UOZfNGw
         UwwFxXQYYKh3Zi7n8ZtAfgnp9wgin7lX2K7EP0+z5JguwUFdPZXgnfIK3Net17v2SR2m
         4w3YfY0gCro/9YRJNcJqVGzyW4OHXk6NNcXZpQr+8fOWPhkwFMnQp15iKS0AHpb5hesr
         0zWMX+3bkYIkjphT9bOoMGvgVoSiwtLhTRgjjnfPNMbNU82Hqz66o3NcSUPSpOF6X0Vc
         gbmw==
X-Gm-Message-State: AFuF++lNbKRoc1t3boHWK/F9ABJeLqqgNiSKiCTlOziZ39lIlLOPpFVd
	/3Su0msnQmKfNZn90lQsT6TH7VqQWmT2NpYVx8XBCB3A4WsbP6ycvhb9oDQeXkaQIFtrTLsrO5p
	fCNCXZYK0sZs5ZJbFgqlbmIuSWb4xl64=
X-Gm-Gg: AYBFou0qZpGkvHwoG6OaSa9eIF2Q6lKqgxqrHsu7kVoP5iaCKJXic+v9Elccyh5txIf
	ymgWUeB3b74b0xgP6bQjIXzdX0sEXqTLgjRRmD3/6EVB/SLLooX7iVvylRX8HggNxY2mK10iA7e
	8UBdzCqfceWDi/S7kfebz1RT8nCniXTS77g9St79BIKyoDPmkC+BWeHM2sKkI0wDzmEcOfMlyJq
	KO9TF5CqyAZvltrev1Y8cmRoX6uCm/SjZ6+Csd8qiD4BiULEUtttaLC57Lw9SoxvICUPPRgZn2r
	Kh7ToK5XSnP9gkmb+36mAOKZ8bYlxVrmfZVnQi6jpb+dIwN06q4wRqKyD1CsZPg447pYSwytaXb
	WjBrkBBViB/jElVFy5pe4rLyNhcLV
X-Received: by 2002:a05:6a00:2d24:b0:846:22ea:e171 with SMTP id
 d2e1a72fcca58-8616809b0ddmr27662552b3a.3.1788730089364; Sun, 06 Sep 2026
 14:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
In-Reply-To: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 6 Sep 2026 14:27:57 -0700
X-Gm-Features: AcwNN1Xot9l7EgefYBb1-TDJ5GKy5LgWnTHeUrsJtELw63EywZ96HZqKdkGcUQc
Message-ID: <CAADnVQLsiYikybbLrBVPTwhnp5_VfEYh2k-HVGJoe2F_1kvATg@mail.gmail.com>
Subject: Re: [BUG] libbpf: BTF dedup merges arrays with different element types
To: Mingpei CAO <caomingpei@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:23=E2=80=AFAM Mingpei CAO <caomingpei@gmail.com> w=
rote:
>
>
> Proposed fix
> ------------
>
> The second array descriptor should be obtained from t2:
>
>     a1 =3D btf_array(t1);
>     a2 =3D btf_array(t2);
>
> I applied this change to the assessed source and reran the libbpf linker =
and
> loader controls. The output retained both types and the verifier accepted
> the program.

Please submit the fix and selftest as two patches.
