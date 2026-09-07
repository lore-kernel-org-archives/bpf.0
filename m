Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F173F6615
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810683; cv=none; b=fWq0v9Th0MyPQ1gTKJRwuPudlAhU10FsRdmTnhTOEwJoTGH/gZWS6o8fhN+o6e6cxX7gOzWZpe+9SWfon1Bhww3PTFsrBx6KiPXGY/xfDXdQTnSwXZ/uc4dPikcSMMpE9/kS9lfg0IjQbwVKjY/BQqA4gLOqsAb02SQ4/jV0tYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810683; c=relaxed/simple;
	bh=IkAOD52TRvuG1O/4Ub8aY84lrUQIIUmjTPiuK5b15TI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dSfTGtqJ+8ohpMWehklSsZaxmOZmlQ3wQx7BdjO2u1zjKp0eizWE3jTDRwyLOXIn+5xtp8DYavrsX1ZjY7PtiVg4iEeOP+2rufnBtW2cec5QKO218rLqNjsCOIHJH5n8hOJGC18ebEdSWWEQ4yHineeymydUuzprbyjVin5enE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbQeY95m; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbQeY95m"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f57db8b5a4so2964932a34.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788810680; x=1789415480; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hn4kdaO+bjAGm4qgxej2R9Cm/StZH9qbIx/OM9SBJK8=;
        b=jbQeY95mtf3RtbrXtsGx7EktJnR1jAUMnYtKt2PxDIELJT422DNJbXnE72PeajsMih
         fu1pCZA4Jv/lc2r+rnpUUOSNGi6Uwj4mdahXADV3O2dE5gQsotSNPCf83KP0khLc9kWi
         IRK98MYPZ7fKMGlGxCt12N+KEVDr52LbwA+7eqQGMf5wFVRFzxA2DS2cqmmWa6oYmQvr
         uE0pmCxqjrjdC+U7wMEN1SOO/nE+CbwMvpcZmPC1T2LREjFY+8dykGgblGwpNws+rqIf
         FSpkQZ63j727cT1ZwXi9yo2+99sVIUzDpzKJ/XSxQvsLAfWdCcjONPQARVWoPrwjxNZo
         oCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788810680; x=1789415480;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hn4kdaO+bjAGm4qgxej2R9Cm/StZH9qbIx/OM9SBJK8=;
        b=P2GrQDn3thoxT5XggPHPyLLox5PtndIYXLD/sUh4c7HIw+HBT8VMXFTOTEHRf9C7pK
         Drcvxraw+IwzrG1Mq12+R8y5hWxrd0lMWfax9uSklfCp3iUMeKrSJzFfL61bljiQe+2C
         08hsRpSJ8R7R1q/Yvgbsd5Vprmsq1LAhPtNLC9k9l0bqJYCwE2aXBkt0TvmR0NinAjdo
         ihTr9eZkw4jmoXmurhOONSonSPKS/dD+K9Kb/aCvhVs8EaZUWDfYv19ABIe6x5I9puCT
         xb53i3nGeBYi0h6m2V1rCDRDzqxaRNiFgnvxseUCxPEFIpS8ZacvjHFBzw2asL7cec6W
         biZg==
X-Forwarded-Encrypted: i=1; AKwUvByl9Br+WXQPTgZ5JFnz0ZJIlFYMmb91AaZHL8fbpa+XKO0ITMdwbgX3ylwaJy1LPTraYNI=@vger.kernel.org
X-Gm-Message-State: AFuF++kUXmKyvOYf3U6N8SwslusWQyaC0PXyHgQGdgQpkVLRwrM3AYe5
	Myi1Id0Qc5/XuWWgpgGdlR/nUA8lJf5D+3mLRPCCAlTn4ABZFrwV6v6Q
X-Gm-Gg: AYBFou23MH9gpNI+LSig0gYrgJBn8WrzqkDejGRljNieotCVpOZCe9sgcJO5c9+mpoj
	vEZV2ms5Yh7nDHavOtHGNvGB72Dje8lplHa9E5U+njJF8go1ObTtfgjTjLBiZEmcVqcRDb3jxE4
	DqE0nXBN0zkWlKx+4Z+1jynT/zkymZDOIRNHLV3u38pNZstWTjHpodt7v7q6Q0cr0nWMv9Gcrft
	zQqnpOpydfY8dGXJ0UeZhQstX3j336sJMyQ7Tk5ObHhpd+lW4hBiYjXep+zphwFiCrP0jUy3WiF
	u1cJXzXv7ytXk1+4t3txtDPsWlHRHEgza0w8CDjnbH/WW4+g/uWdWFua33OFURUa3IdXdl/WJ2f
	RUbzV9fs6WFhBiuTZ1+otTayE1FcCaaiKHI+aegUTzO29WjfNnjMayWfz2ipscTFDJ2AQiGTND6
	lo5nGxO09FDnUNyxKDDZoXfMUDoIl+aXXjByzsHm1UmF5EBUuzoCGNoyq3AM4DTiTyyh+czRBO/
	4GHJqQLp7iaPc2reCF40/KXnyWHQO1JnScSj0qldWI3pQqhnUkoqCw=
X-Received: by 2002:a05:6830:a8b:b0:7f6:96ad:36a8 with SMTP id 46e09a7af769-7fa1e2c7ea0mr15894586a34.8.1788810679996;
        Mon, 07 Sep 2026 12:51:19 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7aef680sm12847166a34.26.2026.09.07.12.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 12:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 12:51:18 -0700
Message-Id: <DL9CGP0NFZ37.25Y31VZH6PKPQ@gmail.com>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <tangyazhou518@outlook.com>,
 <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Add UHMUL and SHMUL instructions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <eddyz87@gmail.com>
X-Mailer: aerc
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
 <20260902070534.2141812-2-tangyazhou@zju.edu.cn>
In-Reply-To: <20260902070534.2141812-2-tangyazhou@zju.edu.cn>

On Wed Sep 2, 2026 at 12:05 AM PDT, Yazhou Tang wrote:
> From: Tianci Cao <ziye@zju.edu.cn>
>
> Define UHMUL and SHMUL as BPF_ALU64 BPF_MUL variants selected by insn->of=
f.
> UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product, while
> SHMUL returns the high 64 bits of a signed product. Keep off =3D=3D 0 as =
the
> existing low-half multiplication, and assign off =3D=3D 1 and off =3D=3D =
2 to
> UHMUL and SHMUL, respectively.
>
> These operations are inspired by the UHMUL and SHMUL instructions
> introduced as part of the PQR instruction class in Solana sBPF[1].
>
> The encoding and immediate semantics differ from current sBPF.
>
> 1. Solana sBPF assigns these operations dedicated opcodes in the BPF_PQR
>    class, whereas this implementation selects them through the offset
>    field of BPF_MUL.
>
> 2. Solana sBPF initially sign-extended the immediate operand of UHMUL,
>    but later changed unsigned PQR immediates, including UHMUL, to be
>    zero-extended[2].

Why did you switch to zero-extend ?
Sounds odd to do zero extend just for these ops.

Overall the patch set look pretty good.
Please drop RFC and respin.

