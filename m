Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197075;
	b=tgvRHnyXBbn1Fps0PhDU2NhV8BozVfc3BWheWPtEFr2WFbk8oviSa1fvFVln6Syk2Ls+
	 ch9hmsnqWJGSRY4zCgdGNPxzAYrFfnTAUm3P1m3lm3ko8amw0P73Mk3mQkie72h7DlJh0
	 3u3cW/5CfIKiwi2xT59aB7IaxODMBagrQZ4tAbwWVYhIWub+T14cjP295QZXQuZEW0rvP
	 zax5BcX+rMZIM5airsgCUe972LtJVs97kipI8cY9O4eVw3fiCIT+UHOD/QI2kIJol7I5u
	 UeZ2jrzkpti5TXoXGTjq5M6z+k11dOtBQ/DEIWpcQSGjFU/tWX0PriPsR+r989wXAkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=kPsd69A2+a4mJDMzqdrKWWQyHrkDyYZqGcjy6N3pghA=;
	b=ozUf48BlsSn5lzook7PGasMsCwjYH5uL8C8KMRotFkvcZc5j7w4eePMIHhio+ZE5hGxL
	 /v5++Nua0P8GQdpoogF6DH6zs345ndc9USjiVLOCSBt2CeBVAgrNcffWNVMUAbpcOnsF1
	 PjXReV8skjpSAqz5x43Wp6jrR8u900m1AO/nR0ejHKbI0PfVGb9sFEXiIv+gM1xhjyVkr
	 n61O4Jqp3hCRKLzybTheZJaEhkjkIStvL/PRrvBdqUC/uyLAaCY89I0UHqbqzJ37wbvZm
	 NHtkNBjqZD3IeGfdD+bIpQFDrkQ0ss8brQ0p9xSIraG+GjCJJ/XT7+qASE3/+Eb+jyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCeBbIKL;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3C606A33A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 17:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC3C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCeBbIKL
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso607633a91.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197074; x=1795801874; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPsd69A2+a4mJDMzqdrKWWQyHrkDyYZqGcjy6N3pghA=;
        b=vCeBbIKLYfmAmONmChx3TrD/zsobJbGFHQUN7T7NjudbZ7eNFa0vVNCEZxEiB0IB0I
         VIGvibeUx3ndC9N9Hmd/p7qNhkk+q0hgQx7uCpHP0lrMTXaODpxe2Z7PTznlr2IoWDQG
         uJf/DMbCA7QodXVOJHl2h+68iDGo/u7dDsQtlxRyFkMIbodt1k9ge7tOaClnZniRpNMd
         VLG5vwc/4sATIWJLgX8+LXLroG7IHVlJi0/3e45jNXi8qbuWfHPu/CCuLoquQmeKNJuq
         zK2d/jBZuf6A3OoB+mFXcgePyEaN8EtwF6KnPRa/XQ6seNaQ9NRID1FYtsPY6mU+sqQf
         ZuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197074; x=1795801874;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPsd69A2+a4mJDMzqdrKWWQyHrkDyYZqGcjy6N3pghA=;
        b=HuvjQ2nkyq18eVAwSAyn08PjSyjmCM1ZbnBfr8oI8eYWFoT3JHcRkR8Tw/IP/dZUym
         WkVgxtBsP0tYrOlKLfjGuleUk04Rh5cxuCeCrdVUaQbluxmGz36C9/St9rju6cyqK/NA
         E1VTFiL3J2lD2RcRmE3Wj0HO1nB1DUW/t20dBNLgf/zi3R3wmw15IGnHvcX+lEVbC+A9
         MdZIMHmC/X0/0Ruv9VU+mTGpCV5L3W2Q2x9G6mEE3Tp100lFxKlDR6HFWfxnL6vQF4xr
         +8epU88pz3UoVwkGqI7Kor190blSN6oqt8lb58DwLPS+qjK6lfkbi4RUl56TXSxCnTDE
         jbPg==
X-Forwarded-Encrypted: i=1; AL+hErF7lmPb/8EykU3LlRhXqLbThh9yhc2WNSVPdvLhpkwMR8l7IAk+lUFQekCEcxaIvFAv7iY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YxXEIZsgMADew+7hTHNa5F2TffTW/Jzn4jxxGiP7/Z7m6OJXD
	6nONXrrgJoiFMKFfuJZBEcpJFhhrJWz3LXmZ7Os97rRDf5GbNCxHX+ye
X-Gm-Gg: AZFdTZfDW4A7+tq7FFkVwRfpk/b+0A2MMyeyTrYcLC6x5HehQg5ljj9rbemsJS8q3XE
	zsWyrVZjA61UqLPnTI/Ny7i/dVfLiOoisdzk/1AnWxQO5LKGwsloS0QCHp4jsX3zRqh6V+byEdg
	ON7P7R68Po1ljdDVAlD1XM0i8fxlg/9C1Pbsn45nH8Mv4VNRqyrGyS0WFfTzd5UueTWeQXvLmbR
	mOVJB5AdJPyQqhvcjN28g6WU4y1IXCSsV3jnyOIyg3H0bnACLXRyoJ1ke5P9AvJ3Mhl7xI49qdA
	iw4UDKNMk+iowL4H9r/+d00iN5Y0K2qHjILAA5HSsRsNHESDNaxa8/T4cAr3vnCqoh6s+gI6uD7
	gbw7Nky+prIzVpOgtVOzqn6pH/Z1EsNuRV1fLBnGz4eZ9Oowa86AHbC0Fb8CicgsfG+lrLRzHPZ
	qYQnZFPWxF5rY9R5ra9quRob9q9afmxxr7HAR+nqYplQcE1ReB/f3hTzpysovMmA3588g2sXg6J
	X6CvWuy07QWO3V4mhtMU3v1dFeq3Qp7vm4MYGVdDw/h0WT1LAoIuemwx0uxvq6UdOYSjXYwbZRz
	ScE/OycGTL8YewDcSnQmYt8n368yRodZiXBu9qBhOwQry55UMNgqvg4S4kJ/BQy/incxfY7FRid
	2f57oWgV3PlSwp/UqRND99fZtOPEi78NEyA==
X-Received: by 2002:a17:90b:5350:b0:3b3:b414:9aaf with SMTP id 98e67ed59e1d1-3b41c93b4admr2274822a91.27.1795197073726;
        Fri, 20 Nov 2026 09:51:13 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm8013926a91.6.2026.11.20.09.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 09:51:13 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 17:51:12 +0000
Message-Id: <DN0892611M0C.3PM5AWON74JW5@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 05/49] bpf: Limit the cost and the memory of a
 load
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <9249cfbdbaf07a35d422dcebaa40c68e8536a3d45283a234495ec7abed2d229e@mail.kernel.org>
References: <20261120074430.2704488-6-alexei.starovoitov@gmail.com> <9249cfbdbaf07a35d422dcebaa40c68e8536a3d45283a234495ec7abed2d229e@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 12:25 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> The later commit 931721673c10 ("bpf: Put a barrier where no mask fits")
> moves this loop into free_pushed_states() and passes env, so every commit
> from this one up to that one is affected.  Should the loop be fixed here,
> where the prototype changes, like flow_drain() already does in this patch?

No. It's already explained in the cover letter.
Each line of code changes in one patch only, and the kernel does not
build after patches 3 .. 36. Patch 11 moves this line, so it adds env.

> Will test_progs -t verifier_liveness_exp now fail?  Should the expectation
> be updated, for example to __msg("BPF program is too complex")?

No. Patch 44 changes the test to exactly this text.
bpf-ci had patches 1 .. 20 only. The selftests are patches 44 .. 48.
