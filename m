Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010034A3D6
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007610; cv=none; b=B+8W5c1KRX5NnYDAaJM/KzUVjXUrj7tWYGX9Z5icIUWzC7+XAs8vH/b0wT+zI8rG4ZssWnBtc2YqMxb9Qllzp3tbitP8U2jdfhwY3FFmQUCKCxIe9avzklxbol0/MOOv4z7hXph5B7wyUekVmYrnzXNNl4hkL4acXaMPN46VS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007610; c=relaxed/simple;
	bh=tp6tnXfYUVTvunUJGA6IJObbm0nZmp2n9QJVkDiFKu0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aaGX/EsloSYub4futZK8Q8O4/S/t+S3uvUqCFzkUJbF5FToTcVjjAaxmtFJQ9kPK5SJgmNRRfnJRYfAN5ZPT+3TO55vBB8b+q9+Tfn+hH8EBxUzSGsq/Gw00gcTFx1+2zKL+BdZDuge+Sqc847CZEgGZkVovVKUOLZ5J4mGyyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGJ5w9NB; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGJ5w9NB"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso433542f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786007607; x=1786612407; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Vagwhw/cfVUYGAfwpyHVvoObwXu5LqHMy17a3izSB5U=;
        b=QGJ5w9NBGSQiRqtO7gs+svm64HNd2ez3sS3hAXd/lsXKOjfs1OPRha5Fzqoh/kVECC
         z236B3yffQU177n1GUuWsRSBvNy7tSlS6tXY2ULZq+qoerhCOw3xR5UHjWlf3BUvp1iQ
         RdCOfQHxEjQshKXCacXsbvnqujznkGbXwSPk2KYLVcD+nXH7pLKQf6klfua/Imu6A7jM
         UYcIYTi4w+Z5z/StwIvGaIhwfr4cdA6NqeKOL7P/hYAaLLoiLxY7EMvQgucgzk18/8u6
         f6rqmFQmzk4CEr1jUz4T0ZsSwOiOPIQIZqOgqQ0fgowv4Ia4EYOUIc39rrZ/Rs7GMHSK
         ln9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007607; x=1786612407;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vagwhw/cfVUYGAfwpyHVvoObwXu5LqHMy17a3izSB5U=;
        b=Msg/5ANQKJiEeHaIVvm/pfj6xSbJP+BkAKsXXF+Io6ZxzsS4XBo5NFSopd0DGJbS5d
         zgVvIi0p6F7Ff34h/Uu/lvRW5ilvAhQ14XDg/K7KySfbLGltYLy1xBo4bqU38ZvTHXqu
         CFL30C+qMMG3+l8hqnpSSFIh+Gg+OMbCY6eq0DPCxTkzcrhmbSP/uiPL5J1DcNQq4BY4
         3wm1CAf002Vvfx+vmcnmjATvN+JItouiwTNaiGEjyv+d8dB+vTQ27qJWIILuTGphxDjD
         tWFPZChonkxbd3vL2qh5JC4V7CN/vhX9ERWVFCxJGxxJSF8SRn8zvcVp7gKblD4MaHxt
         eQaw==
X-Forwarded-Encrypted: i=1; AHgh+RogXUQcVhSA7eHOslneExZAxTIlv4rnI6YOe6iXPH/Vf6/K1SZiJNRZT+HjfFTLBMrjoh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPOulhBdQNkm/+hPFCER9xvq7GepxU6x0KLR4Zrn5rWdyrEEp
	ftpPoBigg5INyruhL1J3JSjf7guhpIf0cT2Woh7aTVUa0sToVcUcWPxI
X-Gm-Gg: AR+sD11K3Zh8/qDq5tOreqaVJcQZWv5ydsL0oqss4/FWJqAIDq7FQ/veAL4esZecXCh
	H3Co55yaJ3EN5Lvc4vQnMH7u/HgNqxI/G+eDi7NiA7h+Ieh+2uuQxH9uT6R0+FqkrIYPe01MEeJ
	XNNAdzkCdoPhHdrchZumYTInWypZGBRCUNVlk6+EWcep8d4rcC3ucJ22MX3kIL+Z5U3FKdHkuTc
	8tI6rQ+FCHZKgJpK4Th9RrNMc67LTx9aGEcal3H7OOvwRTy4iv26SIb1RM1lLG2gkRQUgUjh5Aq
	/SJqViX3qJDcCQePBEvfEu7np941LzeHTo4ETsdx+pkIvlx8xlqNzaGR7xrnNNBA5zuoatqSpoQ
	2WKddbbSS0ZnraK3khs0uVPX05SccSPxogMIBBKisKyX5aiMmEdM7EcktKtB00upsPsfj7Yz3L1
	yaA2TOPqotM+tbg7RzVVqlrJK2r6usGqasvOUxyYR92J3Uc6J1IFlbONrdYpAMj8fIHUF7YMKX1
	JCs7dNr4r4sxK5ZDI/9jS1uE4B4ia7WytayL2GuPd5uCRrb9s25r/u4niEDlDB5AOPSNf37yDJX
	Q0GJhIZU+ae5HUWSE1L5GRC2P0A=
X-Received: by 2002:a05:6000:25c4:b0:47f:d072:87d8 with SMTP id ffacd0b85a97d-47fec48243fmr21702652f8f.0.1786007606831;
        Thu, 06 Aug 2026 02:13:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b183b2sm5200200f8f.24.2026.08.06.02.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 11:13:25 +0200
Message-Id: <DKHQUVB5TV0R.1OLK7GG1APAOR@gmail.com>
Cc: <puranjay@kernel.org>, <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next 0/2] bpf: Track overlapping RCU protection
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260805233940.3966981-1-dingning04@gmail.com>
In-Reply-To: <20260805233940.3966981-1-dingning04@gmail.com>

On Thu Aug 6, 2026 at 1:39 AM CEST, Ning Ding wrote:
> Preemption-disabled and IRQ-disabled regions provide RCU protection, but
> the verifier does not account for them. Current implementation can invali=
date
> a task kptr while another RCU source remains active, or keep it valid
> after the final source ends.
>
> Track these regions and invalidate RCU-protected pointers only after the
> last protection ends. Add task kptr tests for overlapping protection and
> final-exit rejection.
>
> This follows review of the applied spin-unlock fix series [1].
>
> Tested in QEMU/KVM:
>   ./test_progs -t task_kfunc
>   ./test_progs -t preempt_lock
>   ./test_progs -t irq
>

Overall, looks good. There are various failures in CI, so you might need to
update or adjust existing selftests.

Make sure to include selftest changes for _existing_ tests within the kerne=
l
commit making changes, so as to preserve bisection. Your extra tests should
still go in a separate commit.

Also, do we need that was_in_rcu_cs logic for bpf_spin_lock(). Would it be
possible to drop it and do it the same way you've done it for other cases?
If that makes sense, I would fold that cleanup in the first patch as well.

https://patchwork.kernel.org/project/netdevbpf/patch/20260805233940.3966981=
-2-dingning04@gmail.com

pw-bot: cr

> [1] https://lore.kernel.org/r/20260803112615.3362122-1-dingning04@gmail.c=
om
>
> Ning Ding (2):
>   bpf: Account for preempt and IRQ state in RCU protection
>   selftests/bpf: Test overlapping RCU protection
>
>  kernel/bpf/verifier.c                         |  13 +-
>  .../selftests/bpf/prog_tests/task_kfunc.c     |   6 +
>  .../selftests/bpf/progs/task_kfunc_common.h   |   2 +
>  .../selftests/bpf/progs/task_kfunc_failure.c  |  49 ++++++
>  .../selftests/bpf/progs/task_kfunc_success.c  | 147 ++++++++++++++++++
>  5 files changed, 214 insertions(+), 3 deletions(-)
>
>
> base-commit: 11c1e836710dcba03e50454a4eedfdbaf8d3050e

