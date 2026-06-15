Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6F3D9661
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543982; cv=none; b=XUe0Xu7f/wKA8GVr7MQGN3XhljeUUCfAUBTp9cLcjm2rJBQUMmPA7mUNEjMNGYDflAAaOl/M2kZXjHqzBDVLeAAX/6sCthlMDn2D8HLi/s9RjwbX3Ozr5GSo9Wb3/2yUYY3R5xXwSzEQOb33lg7PwG0zf7Z5QAI5Q/MIyvvNFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543982; c=relaxed/simple;
	bh=pc+4G2GsAw6cjwEmMrzoIc5kPC5M4vvHq6buvisX8qI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTZenBzXdJupTZGmOPwU9HexrvefMUNYhSfhfHGy0ckuyCjTXIZVUfJ4q7rW8H/DO0NQhj/+SGUOk9O0iA3cCqasw15Qsf16jU7xW+VHZshH95b5Cpr07IcsmXCe1+fN+b0qXUn0NkpQLKB6mm3pqNwHhdyPQZ6gKxocYUdUQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE/aFE9Y; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE/aFE9Y"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30b6dad2382so2683225eec.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543981; x=1782148781; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pc+4G2GsAw6cjwEmMrzoIc5kPC5M4vvHq6buvisX8qI=;
        b=YE/aFE9YM7Tcm/AOvEyWwt9hS8yQ0bb3Mc6FWS8QDhyJp5fmZcFZkZWOlnrSMAGWCx
         PIGlIkcQuzlfsqJLU3aJ4lnROjpfK81GiPSlWWbCWPbdbP0Vw9sN86GGvmj4Vy3X3dJB
         qz3ECpdpUoa3l9nsqhuEoOQFKWo0cXho1NEInwgGwclVSJPzJ70bIG1zKP8FKDF2uHJR
         CtpiZeeQjXuZMT4lQJg4ZIyDG/W6oxS4CDB7p6sVaLt/MPoEqYmiEoS2K20rUVZ+Tofo
         m/DZv0L4Yqxxr4zPe3pl7rOg9tZ67h1T8NfzvKx1gL6kUgaVlQx3Nq40GTmjSTsk1dO2
         23LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543981; x=1782148781;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pc+4G2GsAw6cjwEmMrzoIc5kPC5M4vvHq6buvisX8qI=;
        b=KR9NwdDOU6fPZImZHJn9WxVPwt5PEKhpVU1LBEVw2h21lkEs+duG/ZwZJdS8Y4VEXN
         XNpCDXPLiZJ/6Dh3srPjGV4+nnG/jKTt0QX4rgSEKlOMprQAZKU9p5V5IEa2nMQZlXlr
         jhtUZM8313gRPhr5muOAq/U19UQtP76TuOxDKI9o85Oj7QIBEptsO3q3rEgRbKDAuOzK
         Ypn8KlPbjCgm8Gb0IRbqF5r3tN0YhZJZTx2OuJRG4wxYhvgGVwOPi26O6R2s5lf1zlB9
         Sd4fsRU8ozkyE81YF+muTUh6wOboZHvxibMo1WzeHz5snXXB8+tTg6Z5ROXCl16D2XsC
         dYPA==
X-Gm-Message-State: AOJu0Yy6Qr/U/k9WnHWFt+Mdi/KtbSxnJdGAwN9OiMasCulGX+C+bnKF
	5eoCNKzg+gJiU13UbhrrA2Pz9OMSHF50l2fELfvV6Xh62fOEUZZfY9wV
X-Gm-Gg: Acq92OEs73WE+r+mg4JFma4hamV2ZqnKphg90lh9F0rspyP/9iinVwY33McBUuDsJmp
	ji56gsux7Feur5WZwn+qSWnK5aduGq65gA+/Xm1EitaBWOSqgOD2mJL5HWdMXDxrtinoKJO9FCy
	38re5uFf3FneMnc10n9BF/TiOLzNpgShEjsK1IFIKis+G7MkPYP8XsQ4dWDbmW/f4XMgq/sXs0W
	3NnwYtTJX+NNtB6EKc8Fiqyw2SEKFX1wdPs+0zKbfefkLv3MK6P4H75zEy1SApIH5tcLbuVg3eW
	fWARy2L/XVDcLJj5Mc3PvOgCvyHWrtrlTqpM5baVSmW9ZCLpm91mvPtRAvWsudqCT3aVLDoH+e3
	amb8mxiw4LBl1t54Ltaborza2VZj3guavFhPrv815gGb36s+A3UnbMYBHvsSyJJNyrv7t2/CNP9
	diQqIt401wanmkwPzml+031FKC3gOkfWtozm6rrYOzr6Dv3NGk20kfy3tGiVTcOFtaxxCWY0FEt
	2aE1fqYQXqrt/TU9A==
X-Received: by 2002:a05:7300:3212:b0:2ea:b85c:153d with SMTP id 5a478bee46e88-308200b5d75mr8177066eec.27.1781543980562;
        Mon, 15 Jun 2026 10:19:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:755:4880:8bc0:de02? ([2620:10d:c090:500::3:317a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm16011974eec.3.2026.06.15.10.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:19:40 -0700 (PDT)
Message-ID: <703aeb9e7f93fa35f992fde04f6999974475312e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover half-slot cleanup of
 pointer spills
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jiri Olsa	 <jolsa@kernel.org>, Emil
 Tsalapatis <emil@etsalapatis.com>, Shuah Khan	 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 15 Jun 2026 10:19:38 -0700
In-Reply-To: <20260615-f01-06-half-slot-pointer-spill-v1-2-47f1c18a8965@mails.tsinghua.edu.cn>
References: 
	<20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
	 <20260615-f01-06-half-slot-pointer-spill-v1-2-47f1c18a8965@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-15 at 16:09 +0800, Nuoqi Gui wrote:
> Add a verifier regression test for a pointer spill whose high half is
> cleaned dead while the low half remains live. Force checkpoint creation
> with BPF_F_TEST_STATE_FREQ and assert the verifier log reaches the
> checkpoint and the subsequent 32-bit fill before rejecting the partial fi=
ll
> from a non-scalar spill.
>=20
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
