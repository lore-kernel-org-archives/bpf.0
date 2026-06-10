Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9F26FD9B
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130566; cv=pass; b=rRCET02wo78ef9Crre5jVD+tfwiC8tSpQaLldNjXQ5NNHsoQpShP0WmuFqbH25XqEcrFgx5/oPRpXpacnbERkGyExxJfQOkXBgyS1UfUdg/ewkRFpKudjz452p1eURM5mAt5hCbFZraHIFbY/hX214K1vLUd0kC4lWmgoEvEuDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130566; c=relaxed/simple;
	bh=CyDkNw6wSu5u4LU8xPDaIJrnhT1DIGCoa1+VgMibflY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym/HLWkHeLX3cB+TakHD/Kp5rNi23Qa79pET3uRoOWrUHPKFAlP/RuDsYM6LVQgODTAMul1mMI41DVnUO4SG3qExvfGPuBF5A+AcIshvVhY+qRIpVWOe/0D3y98nakFvg9OSF+n8OC6RCzhqp7J31Ph/d0j0daigbBnWvwzYvAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3vedT+2; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3vedT+2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dfceeaf168so69734487b3.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 15:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781130565; cv=none;
        d=google.com; s=arc-20240605;
        b=AS41OSBVTVcIXVrIgldXXI7hrD3xI2yMDd7b076RJHg544TQLkuGJEYEclHzb6uU1J
         moLXaBv/KxC/YeAAN3aitRLKO2QwF/C/WmKQ082a8+7Zx1LL5jvuoNsaGHy1w87KuNMS
         5/AGE7V1ApxJLDLcr9JXQOgiSpc0/DnTK18PRMzBDUCFMdg/m2aFVx6IHTVmftdQH59O
         /148XEJRbRx+ECEvCRLfQKhSwHOFRvFWDcQHQ7jQFGlZ1kn0qBjjuyGF6nf7Nxrng2S0
         2H9+yMb7cFhAS85yZ0X+nGPQ4szVJHIb5MQI8x76/9w9L3oYLX3ACbX7Yw0CtrNsdaWy
         f+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CyDkNw6wSu5u4LU8xPDaIJrnhT1DIGCoa1+VgMibflY=;
        fh=R1WqeyRb4F7Es5NHig9d95mt9R2BAtif07vwpuArRe4=;
        b=bTWPl0dKpiVCqYSMxXR69bJLoJuoq7NkpiqvTKRe3JZYlf+1zvbqLz2pyGNa8Hgccl
         ZTujpmkDXcQsTQGYazUVx2sT9V8BGyyirkCvlLUZQ7G9SCV8Hv0lIkAxHauGMz55exIA
         XK0LOIfGnK5qTQtbLv4AdAkJUCPdr1N5XiCuBMBrDKDykGvpGGsvHpGRJiCklDo38Vzw
         TEKYApsBP5hRdQ72Gn2js4XwnJZYLupcwc8LmOD4/ey8SR4X8n5pxdJJ0D3grZDpxmCa
         7xjnhiOVnAGQMw3CS3Rq0vhfBdVw4U5n5396mtHYmWnH1fJ04VkNDyo7H5tLPAxm+PsE
         4aXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130565; x=1781735365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CyDkNw6wSu5u4LU8xPDaIJrnhT1DIGCoa1+VgMibflY=;
        b=C3vedT+2jdM1HPB+UXa3z8wIemeMkLIcI3xXbGwYdx9fsKz0vWqJaWULP4hc9lJ4e4
         24NG429A+EeZg3il1J2c+S+IDPGQQT42h/KS0WdCLjgzRyOV+KlEl5qmHdK9lCn6LGsC
         xi2lKiYYlsgoPikWwwjcW63aylBz2y/9xcedO0iNZq3TE4JTez5hpAAJcL/IJOSFG4WL
         hG177GG3ZCfOIVZZ5AVJE/eMh2CiGZ8ZJbu43rCqhHI7/7Ib9s5mm5TEmde4HoMyDXM/
         y3q6LzAwpMid5rxRID+Q/koC68cvKTK7ce0geq2mmKhw7+XuCnInz0AB+e79lSeRoE6P
         J9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130565; x=1781735365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyDkNw6wSu5u4LU8xPDaIJrnhT1DIGCoa1+VgMibflY=;
        b=mh2ko+Evo1iBvm/mnHiAEA6SHmnYBkZj5r7pgWFmQ3fKiTOdf/f/6Xkz1eMRtDemVB
         t+wmTUruky5CiMedeIAdD8nN7+Z7pqPJPAl9lZI83oaq1BTh+Jhg4Z0XmI0+cnteeheq
         kZqOy6hvgcmvDWAbdCvqVwvb+u2tf8+xw5z8xZIP6my0p1SpiUaHowvhb+U/FK/RwOut
         uzbqXzil+nNSwHBOyZJamtBqOXfbJr+ZqzKhk8SZXTkxwg+k/J+c01F1xrqMMvrS90gz
         iUfl5B21n5s2d4fJrMqV8hA8Y0NAWIN5ce0rFDEM2PcMekXwErOQmuXpdbz/qWpQ4iL7
         I5cw==
X-Gm-Message-State: AOJu0Yw/dmjSmbu5x7VrfyFkf3pp0iHHSEgJA3bfDXQGqjquT/ma4HvD
	UH8szKJiDwq3MtMg3TGBPfzF2ISaVe+fTVLbqSmxGb2V/semw6Y20jzy6CFFtpIk4e1ASbM4xc1
	E/WNkDfJ5tGgLz7FRMELM0fZGaq+BZHc=
X-Gm-Gg: Acq92OEgKn4DVd7FwrY6AReTdJF6kY8pBCR/68QY/763UZJDPdf+XkDUTt6yo4c7o7L
	D7EY27lIEox+68ZHR7T0R8QUHxFN7+CkCl7jD6yfxdBi1bEEf/sUTMiCykL+79Nxb/ROjyipKmt
	2Wwr8WdE00nZNpUAbkqg2Q2yGLj/0Xyz8FYLI/BMQ7yMYej4nRxYPJO6OCNuSlhN4dcCaMiwJyv
	TJE0QH40brk3WSG0by7VN7n0fP1/r6NwVJzGIFNYqdKCAYGSFgfIaYkuX7Jw7H+P7cmgPtUTvB3
	a0mq/FB7WxZFrr8=
X-Received: by 2002:a05:690c:e3ef:b0:7dc:a5a8:8b8 with SMTP id
 00721157ae682-7f6553fa56amr2810737b3.7.1781130564694; Wed, 10 Jun 2026
 15:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-umGQ9edRUCnaLYTW1F2wbRDhxM7RRra545ZYbM+8++ModaA@mail.gmail.com>
 <DJ4UVMEEOUIF.8C5PH54S5HSK@gmail.com>
In-Reply-To: <DJ4UVMEEOUIF.8C5PH54S5HSK@gmail.com>
From: Mahnur A <s.mahnur.a@gmail.com>
Date: Thu, 11 Jun 2026 00:29:13 +0200
X-Gm-Features: AVVi8CfCcRXCgFOtCfrRs4muD13XzNkBTuCP9l9R7H1tumItWJrSsK6eJS-JZBQ
Message-ID: <CAJ-umGQV_X7nOXTqYg4_ok9FgypvRYiD9hMKN9Cr32JGfp9Sow@mail.gmail.com>
Subject: Re: [BUG] bpf: Tracing progs on the stack save subtree can result in OOM
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It's a known design constraint.
> A bunch of things in the kernel need call_rcu().
> bpf is not immune to such requirements.

I'm sorry, perhaps I don't understand your answer.
I get that rcu has its usages and is required.
My concern is:
Should bpf tracing programs be allowed to attach
to stack walk/ unwinding functions?
When any memory debugging mechanism is enabled
it will trigger any bpf program attached anywhere here
to run and keep running an exponential amount of times.
