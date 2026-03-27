Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911123FBEC8
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633559; cv=pass; b=Z4LuJgfC+L++Tk+VpEuB1sJeM84H5PIteGOos9uvvX1hNmVz0+ryKca7p5i/Q9Jg/ceu2snDy8GB2T486mGGqpW7J1EG2X3zkrZCcpQwMBbux5X+bA6M+76ullrftWPHifyyba0MtfhRt9S1G0M25/SO+f7WgsX+ZNnklqGwd/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633559; c=relaxed/simple;
	bh=m6hW95/C3ET1V9mEwYcyKNAogg+hpF0krbdZ9S9hmMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf7Ejsu5U2iBXMkgSTx6gXwY9Xm946wppC4iyEOn0bpviNx8ZxED6tdB0PKXH1ZyYDzA5op6iRexMJFIdOUDuADhmPd2Zvx1qzhZjulYPO91quyi5FjxF/GkIpyeNdeY1Z4j7+tnKcvK2MlU5FfSNww1brmTuIU02fBwR1sJVbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdOTT6AH; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdOTT6AH"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a70b4de9bso156827c88.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 10:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633558; cv=none;
        d=google.com; s=arc-20240605;
        b=aCTOFRez8Do/FyMr/geK8lcCAa8HePsspQgbn5TzREpAVIr9j25vSHDTKDtbMi8j9R
         wdSkcRqxA0rYy4+XmKM+SnR2F13NT+0stPy7UUBW1uv3dHTbj/0MpOtUN8DrsW1GPoJC
         4nh7XqymovYLJ0v5Dso6aM1MQSqK4YFiUgOzy+De6SJlvJerOnezTCxfEQdY9aQzyT4Q
         IDYF++Sr+2OtVIvLIeGufTO5Nx1hwdUxi6shLjLbyZbJKDdSv1+FwvQw4sWzwdPOnxdS
         qR82I5tsAmlbD5fo81axdq8I8axsTB66yMRC4mPbmY5RWcGP+nmoVeJKbYP7SEkwuOFF
         6vKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m6hW95/C3ET1V9mEwYcyKNAogg+hpF0krbdZ9S9hmMw=;
        fh=xxOFDy863w12N7scehl4OGSiqJGvtMfXY7isZZnSHD0=;
        b=CniuAO/LLyFk82KWaPEa0+y8NYN6QLzY1HckMW1F5viCazwpLX0x2ddN3fZbEHDXnJ
         8ENo8pYGQWv78zdmRkeoOW1s/5EP3FZBx8LeDa+2ndxba49dB710FzzKBlRC0heRWBPw
         HkWRRI9ytsfX7Sj2cjq8tyotPGKMQU+8PPAEb3aD3jyaory5PYPuFGxaEchLPtI0P0+Y
         FMOdXHgfs8uE9PWn/i5wZysuDQhj/7n5Ap1IjfwGK8bTsZS2iEtck2RyobCu7EvLqyx4
         eCwG6Ed8LP6mjraXzi8xWe/Am2GAMh68g7X2k2Kf9pjn6yLY2O9JBANB9nMEIpUxkoQv
         dEag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774633558; x=1775238358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6hW95/C3ET1V9mEwYcyKNAogg+hpF0krbdZ9S9hmMw=;
        b=RdOTT6AHvnrolfFcvWDh2iQzspgRJYxk+7Qp0EQ+q+vdAQ8/GCP4oJG0bvmHmfBx/F
         pH+USxFfAT26792b/CLvv8lTIDlrQEuFoZZ/Hyqc/Hxe/qJZeBdVO5XdVDTiyirXY1mj
         BvEhSOgzVpi0KjjKNVKuysIxsNiTA4LnFtAYeKk0+Hp1jmmRd7eU1ENFgnFdCPmIdHyU
         UZVknEuL7cb6C/t4A4xafLFoc0flwFBGnC12icxbA8A/jN4mYmqiJDhTCj33Axk4CYnu
         s+q+UNDvBYtivT2i21GDYN3JX4I6K1WXw1VjkVvyqW0zGcqXlvTRidWNw2jeLgcXc571
         NJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633558; x=1775238358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m6hW95/C3ET1V9mEwYcyKNAogg+hpF0krbdZ9S9hmMw=;
        b=nRMSmacJpfnio6g0et7WQq6izBWsCgVDG7ArL566+vrSw6xqRTO6YPZCOwCwO8tMYy
         +OKS6r8rsMeASdVqytJIvsLwawQ7wzSD43y8mEM/1y/l6NjmajMcsOANTDoe+DQfMHTL
         Ul4Q4F0egXNqcXA0dfxxu93bvvT8vqtIdAgoAhM9RRtwoKQGs8POZycikkvzVOYmo+zg
         Da9M2XPg5w14rRvhYPXzp7Y+rxRo5RvRXWyGO4Tqkhbv9Pt0YxsDcDOGBHLCYKxjxaWq
         4R01/oPUe/mBXEUXJ1kPMjiSUr+aXhIijgt0Vnq5JIybG07vdIl1dugmtSB5iE3J3fZt
         DArw==
X-Forwarded-Encrypted: i=1; AJvYcCV6f5nlKYN6wO9BZ30kKqQbn65sbnO21qY35x2OakF0TfbZxNhE7bhNyu/r6RDDYhYkaDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5GZkk2O+hNWy1qiqBER0AQ0dACrh/uCTASXTSPMqhse4qm6S
	34Z1shK5mLIRDZwUi8Q1V3OIIPYhQRwmr900Javxpt/tyW2csOQYaT4JuOTGtykzTPRc+p7k7BL
	ATsqu0Q9QtuHSWugjn8sYbv+inPVnF8I=
X-Gm-Gg: ATEYQzwMix9BqDMUINwg9ValkRln7ZHXzrDPBIaDnkq4St2ee9C+duF1sSxI3V+ibVw
	RCc+LNgP4faYXVWJ2rbaWPqnHeBFqDTpQZscQrBKDaM+VQJQh2hCNFqoWG9CbB+a6GjK7n8jMQV
	LR565gp4ZweEGjp5k57VIDi66CTqGbaUTqHlgZp5u2wFpNB9maM09uXn67OlftFhQ5nOd/FL0S/
	c2eKsuMwprOCt2JkreYaqMsND1hML4Jy7Xj/0qQK7g4hM1DRybzI3EkrFEKk53e84FSltvhj/rf
	XP1o8vVe/MlEqSr4swfQnhRhqOmZvCaUogo2z/WoO66l7KrlDuXC7mgg54RsBoXzxrGRJWJRuzx
	RfhLne4832p6dKlI3sqBjzlc=
X-Received: by 2002:a05:7300:80ca:b0:2c0:d9be:eb09 with SMTP id
 5a478bee46e88-2c185a57557mr875171eec.0.1774633557661; Fri, 27 Mar 2026
 10:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327114741.91500-1-pilgrimtao@gmail.com> <20260327114741.91500-3-pilgrimtao@gmail.com>
In-Reply-To: <20260327114741.91500-3-pilgrimtao@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 18:45:45 +0100
X-Gm-Features: AQROBzB5tJkP8M6dPCGpMeaOv63a95dhaN59p5xt7LwFdgRiK0mSmaXLq6iSY1Q
Message-ID: <CANiq72nFSyKSUcRJL-uME7QsvS-4aaNN2nVp44W49Q6VZhCJJQ@mail.gmail.com>
Subject: Re: [RFC 2/2] tools/ufq_iosched: add BPF example scheduler and build scaffolding
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: axboe@kernel.dk, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:48=E2=80=AFPM Chengkaitao <pilgrimtao@gmail.com>=
 wrote:
>
> +3. rust >=3D 1.70.0
> +
> +Rust schedulers uses features present in the rust toolchain >=3D 1.70.0.=
 You
> +should be able to use the stable build from rustup, but if that doesn't
> +work, try using the rustup nightly build.

[ I have no context on this patch series, but since the filter Cc the
Rust for Linux mailing list due to the Rust keyword (I imagine), I
guess I will take the chance to ask. ]

Is there a reason to have a different minimum than the Rust global one?

Currently it is Rust 1.78.0, and soon (this cycle) will be Rust
1.85.0, so that should be fine for you. The plan is to follow Debian
Stable's Rust toolchain.

In addition, you mention nightly -- why someone would need nightly?
i.e. you offer a Rust 1.70.0 minimum, which is 3 years old, but then
right after you mention Rust nightly, which is essentially 1 day old.
So it is a huge contrast, not to mention the availability of unstable
features in nightly. Do you mean sometimes you may need unstable
features?

Thanks!

Cheers,
Miguel
