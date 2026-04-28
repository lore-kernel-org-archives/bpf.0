Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D83C3C03
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393177; cv=pass; b=kWYnin6GT4K9MUndF7gX2wljFa33yfZ3DJUySl2Lxoy76ivA+PjYBVoXN8miC0mnwYezkobEVFaphuWttUu2jL1pCeL6z+pVkdNs4uIET4HbzylddCZGqKBHrZ2Uru+hoO/kySY4E9QhDMDyNNaZHvANPDTKylxuzsUHPl1AcLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393177; c=relaxed/simple;
	bh=DfHyIWmvUcz6uEZPZhtRgnXT5Z4TT0B7YOHPAxYe2B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKhBFYHigFbI5I3k9daP7hOtuULDQ/XPwTdeo4LYcAzXRrJzqqGpMVHfd5cPzM901xf7MzF+tGxRs47bmXos4PzHoKzS7gbXU2TAmBEI1CUKT2WjgR43pXd7YN6SJaFPfDMucaSH/TbDFQbxx9O62U4/zJBU3mg0JEnJLiIOLnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCeL1AEe; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCeL1AEe"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48374014a77so150161845e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777393174; cv=none;
        d=google.com; s=arc-20240605;
        b=F8CSXf64bP/3jGvIpYP2m9Lfj+37klj0mkftAFYVt3Zr+sHDs+u4GnQ9UDSvb3s9gd
         HGV27kY0C8sG7ASShL8ovE7LIrInspfczZFuPPWDdyxxmSnRtIiDwLWoJT3/0niRQoSW
         3QuCcHKDaVOZ/JaX6pOKVhGuBkMaTcbhgDkbEsKiOsJ7qqGGcHJ3pSdPIayOcprO1hLv
         nwexcgACghwJ/bamkFNbHkljHyXeBhyHTdvCubAc3IBdAhy1ZISn7eB+RaeBeq5idqCs
         V/9stXtxxh0vnetFhL2dr2TKtRs8Uk7T6LTDr4JKGlkuJ+wPBIgQqRCW3dSW7cSdflFJ
         4/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DfHyIWmvUcz6uEZPZhtRgnXT5Z4TT0B7YOHPAxYe2B8=;
        fh=RtOnP/EqkOGdOJShHb2yEORBsNBfgHE43wAyTOF5k4I=;
        b=Lv+6C10A18jKWQZl1hKMvNIXwgubKLV/nJ5rGTfD1W0o6HPM+rDyGC5Hv6khTWMJB3
         yQ+U0fRSM39nMpsv7JFRuGuigGEEmLT47uzHT7d8ToNuFp/Xmv7SyHBh6YCWVV0vrdvr
         zGYmR0Lr/p4HX97dDdkW20qCOD5+WDZCiZHnX0RjCaxKkim482zRA+8URQ7TGHl52y0T
         2qL4atZQNqfiyEpbSQX2nZ7xnJRqVsAHtIguni92YaptgXiv9np7YO7flghuWFrFIZSX
         RENWAbJ1SesVCywghnivwQJoiZcd/MBntjGi1kmWY14iVG2LDnDDEF4idQ/x/sC0U/UW
         jQDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393174; x=1777997974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DfHyIWmvUcz6uEZPZhtRgnXT5Z4TT0B7YOHPAxYe2B8=;
        b=pCeL1AEerNY+S9guO7kNu46YQDGFIZJ6RtdneBqSYkDp5Qq2b1d1hMeuK91CePPhYB
         8tOIDCLGMwy3aioe/HMFd3ySs9yq7rtSCxI3Y0QiLtS17flHW5CWpkXeYQOLk6t4UGDD
         xwLhjttpF4/Ev+9vi59zv0SvqcqowWk4Ys/BVco+ufUXOF7SxoYEAyH0+S5jk9jPjGT/
         C+50ikgtbLmmtZkI2kZP6FsJlvl7vA0TC7qxkXzdhcSCbiWyW3wxBW5RYotsnNdUb9xE
         YNPOie46mL/nwKaqT9c3x9wR3KQZYk6/LwKsJtnNYlm4Rd3lKpgAyYWwg3z1KpbQFdmf
         wWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393174; x=1777997974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfHyIWmvUcz6uEZPZhtRgnXT5Z4TT0B7YOHPAxYe2B8=;
        b=s5x6QyXaB8XwcVyfG7q1YdxW4dsOgLSOndVZ+dSIkDJKbzb0F/1iKKC/yT++gEPyfd
         R2ntlOF6xene7a6umHfM2Q7DIjxoM/h2bwh7s3gGIM4uGJ9pvAIvpTMn/U20Wo/32WCQ
         dJCG8YfXEflv1q+5GUFH3Qz1c8D/Dmr8tjad+zmQIEZeKtHGsrd10n4DaBULlKGtmQQJ
         Bl4whHfJKb+e8ISEIRWjVy+sfKj2++5AT3j1MwLLhsKq7RAKkWTmeD9Z+WN/3XPYTzCN
         WVpxJqRSsLoVtrTygb/h+m14bKWUWHIY6xQDo01EtEn+2jPcnzfbNrOYYAHoE3tYxuPk
         azQQ==
X-Gm-Message-State: AOJu0YzaAP69/Q77T6/RgjTS1CCiuzifbq8z99SMQ6NnxLXmf1D4VugY
	Q6e17A2BS7dAuMjNbvDiMBuq4diAWvCcb/KrSxjVYoi+dL9Yw+XUULPPBbak7u56XZ+z4O2Ob9V
	PXDv1eTaO6SE324kBfVy/FaqAIgt1BSQ=
X-Gm-Gg: AeBDies5hvNITL3TPlFIFDrTISfbJGWys2xg9+PbHCTEL8oSynZ510vQX389R0HbVn2
	xIQKzRX0cZ+m6rky5jd4H7Tvybwx0domQgEfzRq6pZpI2LuzQ06gZODUmW8UprOTqHHmZpIOUlY
	HptG+cW3WzbD/CDjaqES8AJkniH7LIzW/2KzzZ38RwXsywv6N8uWjrm08/b2Ke7C6xCz2M6AYry
	0wnQAR0Oh0bG2kdyqKSxnUG3IighGV5w44ZOfg7tJNve4ExDChigzcA/lufoPE0BhZ3I0Y8uNhV
	O3J2I80KghaMRL5W3/rQcb93SzmqUUgJfjJ+KMyLoKpNNkdiq4hInI6IqhSxvWTq0zV8mwcIl/5
	Sbqbhped0xPURUe5qtCZ/tHSrGWQhGLiYr48vVm9oWlsTVjlzg3CmTUQrKK6J3aPry2TmEpkZxc
	k8ig==
X-Received: by 2002:a05:600c:4fc1:b0:48a:53cb:85f4 with SMTP id
 5b1f17b1804b1-48a77b19fa5mr59845135e9.24.1777393173873; Tue, 28 Apr 2026
 09:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>
 <30df9a4d569143e1d23a7c7aefd7dca85a21e2c8.1777388107.git.paul.chaignon@gmail.com>
In-Reply-To: <30df9a4d569143e1d23a7c7aefd7dca85a21e2c8.1777388107.git.paul.chaignon@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 28 Apr 2026 18:18:56 +0200
X-Gm-Features: AVHnY4LQ4bB2RjroIbtgerqaf6YvRJwKGXkYPGojwF4A2qDMihii7cxMj5RdBLU
Message-ID: <CAP01T76dy2f9HgY5XCFyjiHf89m1S1XqVRKnZUrquRvV1TRVng@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test insns processed breakdown
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Apr 2026 at 16:55, Paul Chaignon <paul.chaignon@gmail.com> wrote:
>
> This patch covers in global subprog selftests the new verifier log with
> the breakdown of instructions processed by global subprogs.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

There are a few CI failures around the expected substring, PTAL.

pw-bot: cr
