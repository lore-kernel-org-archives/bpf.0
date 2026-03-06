Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A852D2382
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760163; cv=pass; b=H6ks000PRNmnx1kGnmVRlqHR7AhXhaB6b+P53DqTWPLuxMA1L1UjI79o6XOYNgCuQNGKF4N2fNt5XLiTFgeg66fTlYW4CpOYKU+k4JGO6+U8ofJsfMOXOKXJe8+a39v9OqlhTPoj0jL8/5ubz0aju5WKuBcVI5TAo+Js5Jjt8XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760163; c=relaxed/simple;
	bh=HFQK7PansgIbHo6xF+g4VOImvbjiH0HVzCJNwQj94II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uv6Z6X+I3RfpV/jCmmQIWbVvS6KdX4wCdxu3E/UsELfHOKE/lADfH4Dj+PdQRTPVnFVzYRaLZLWmMu5VC5AJa8iYxg0MDT12EgYUtX7oLcIZu9PWEOvelKXo4KO39hP+BcFjoD7dG/+LpwQ2TOubXfpG0GhHmxMpyFBfQlTGpo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXLp7So6; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXLp7So6"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso4881812f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 17:22:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772760160; cv=none;
        d=google.com; s=arc-20240605;
        b=UI+sevBgadAh02eYmHnQQnAa5zVU+YWTAIa1EpqxpZ4jddTDBV0rlce2RPipBg7tNb
         u79A5iUnVFKRmqoK0jaL0YvP+6twl+BR7Nnhoq5LwKlwAmmAxehLZz5PAWH54wTYTIAX
         oiOSIZF0DxE/haoDAN2JqPgQRsZVTaJohtGSUqyuJNM7EAKUjhuAKiMHrRVKy1o2vbUp
         cggwU1j59hwg93P5pOzQ/d0OKQJGJ6EL5S5CJr3cs3Kr9sNMxWCm7KKT/BC/LATxLlf+
         bmrjdRwzQcccjaEtC9z3t348q2d/TERO0MvIkOqFTy2aniILSF2ntzzll8L0iVI31N1U
         jroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AbJSfN5qJiugZdXHi3nYPCFLYqi4faIV/kj44r4NA+I=;
        fh=gjn4ZTapaPxkDOIPq+8sjVtt/tus1tBefSGAe6LV9jY=;
        b=LuVaa4fRVszf/8zQ24Fl08W8TQ3vAi1QMzOsYY5dZ+vFu+RhK1Q1Jj3W8icgSuoIIC
         LVj7KXo0G4luQCQPyOMMay/5icoGmdk8WjQpJNN/vCXHUi0Chhtu1L7LKbj9k/7z67LH
         kPuVc3EeYxiXP11/Tv8U8VC0ewmwV4Z/Ok1uCsRvmlW2a7e/Oi2y+dHwJ7dk5HRJ2IDp
         NOf1zr478U1WeMyiaGED8DUc+3qk46qSgm1W6iX7N0U7m7iCWweo0ic7o7fgUT2VSOf1
         0KFh7kgricMCfwjBfzVi2Ph1rRaUV9ZMmlB36MNXwlr8E2u5gfM3hFPGq2OmBzkrCywG
         6mNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772760160; x=1773364960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AbJSfN5qJiugZdXHi3nYPCFLYqi4faIV/kj44r4NA+I=;
        b=eXLp7So6sJnH44rMVKz85c7HFCnrls5apWx56VmEx84wXfm2V8GQVXtEMfiRY4XQOb
         nrQe2U0g4AN34Y8pgeegqzOe4IIlrn+/JRlfKhYsLfmCN/MZM4Z/qoet5gghFO77b8Ea
         L1JmJh/6wh+Q9nR55OAqTreih0sD9XDMbx/BlshQPL1USInKJbmZzRS3GmrG8Ppy+wn7
         wYYIQnvXqc+2hjDctAFUK69zFakSa9XZXBMs2icjPApRh6ZK1GMcdtGq+GLgbjD/b0Pc
         Q5D7V1mUz8PCuz9SBjlKIvzX3rrG/zmFNxBlOlRdEHeRMhCQHYfT5Qve0LvbxcIhn5/w
         OIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772760160; x=1773364960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbJSfN5qJiugZdXHi3nYPCFLYqi4faIV/kj44r4NA+I=;
        b=T+z9f1FeFk55z81LUzt/d+a1sYW1atm0oSxMuRjcruNVeqSfT9cr366s7fyU6MaV7k
         ZgX6UoMcHoRjkAGdoCEHcQjxUH6Qr6m7TmiTvxH7qnjQcf5NKuv02pW7tH3eQ68FCb7R
         OaQonRvnKr4cTJXk+oyDg7Fh8qw7ZSfsicV6SjzaKU9rCzR8DbIFmCFUiEPqx1tUyi9C
         DjqtbTcqIAQZ3PiCx01dJGwmIKxjWqqFf0G1q6iItJFrmaVYQ+pDmbWSRy3ToueSQ7s2
         5GaXTl4oyQGnTYbmEQGwFtmQrwSDoVmpQFzG8jHFYK0E0i8E3bAS+c4w02X11yFiBiHI
         qedA==
X-Gm-Message-State: AOJu0YyGD6T5KyZzWZ+uWtnqYnXNy9C8CaCu7CC+ArxCql6eGNywh3Q7
	BFt6KtypU73NCdODAmBBXIZph0KI1Bv3j0fNaNhCIzkdjtjekVazaJXECXwmoES/SD8FBRMr4yA
	xFTynQD4GZAdMBfhR82hX96UkcnJziXO3eBoDS0FYFg==
X-Gm-Gg: ATEYQzyZzmwpSQxnlmFkW0kCGlQdLBvdLx1Y/TePqKFKqVgtNp0gaHPiV204sPpP2Qd
	0QeiMxnQ+OYpUj8P4f79AZXnsq+Pv00FEN6kL/FS85pJf8WfUF9YRSEtTRPnSuTvUoeDHWsBwhI
	ZnqEh/Eu1KPBF7Vfp6Sj9JY9MqVx9o8iRWETq8YbfMTfNJ0sPvATZxrK4cdlVUGMXd6UcmFFSOg
	IK9sww6E+LvYmWf6h3zpsgUGOIhC0RUS3ji5P2etfWniHcJ8CsIKy3jT1xdd+PdeZBp8W5J3qLR
	y/jtrpZWt7Sc6nKeaY/DihjNo628jyHv6o8xll5DrwvdbQVxJDPMrJ7GaEI=
X-Received: by 2002:a05:6000:1a8d:b0:439:da0d:a025 with SMTP id
 ffacd0b85a97d-439da66250cmr461561f8f.20.1772760160032; Thu, 05 Mar 2026
 17:22:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305130035.192080-1-cupertino.miranda@oracle.com>
In-Reply-To: <20260305130035.192080-1-cupertino.miranda@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 02:22:04 +0100
X-Gm-Features: AaiRm51DVHyH6HPTAMh96ZhmrX5S-Gf-N7UEZw_OXyaQsqe6ucFzxxyEi7od2Vw
Message-ID: <CAP01T77UGnPt+=vEFXXbcwU78yv5otQ2vmsVnzA7GTCZ86XVJQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Enforce definition order for __msg macros
 in BPF tests
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 14:04, Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Ensure that __msg macros, and similars, used for BPF test validation are
> processed in the order they are defined in the source code.
>
> Neither GCC nor the C standard defines the order in which function
> attributes are consumed. While Clang tends to preserve definition order,
> GCC may process them out of sequence. This inconsistency causes BPF
> tests with multiple __msg entries to fail when compiled with GCC.
>
> This patch fixes the test runner to explicitly sort or process these
> attributes to guarantee predictable matching behavior across different
> compilers.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: David Faust  <david.faust@oracle.com>
> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
> Cc: Elena Zannoni  <elena.zannoni@oracle.com>
> ---
>

The logic looks correct to me, so:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
