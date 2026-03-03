Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3834750B
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562556; cv=none; b=gcZKG6H4VU3nTD2Xl7qAfTa5clVw+8cqjGtKWNwWOIpOvYI2+EYPYeZck/ChPmYCXvJz55gtgT6Tu+6gEHhVDoNwyJVpASmh7t2tXuabN0pCxePEMo3iKCA1CjeB45LoZrk2MH6XABeRAKzuTyRG6A63aCSOqonCtew25mRO/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562556; c=relaxed/simple;
	bh=4C6R4EYALAQuRidXf26G/lfd1PiIbTSMnlrorMjuO2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZGTA/CN7z+LFJ/XSnfJ56CyXVLmdw4vtRlBrWkYpXJuCFwo5R+okGQTwPhYUbRW7JdsN1I08oMA/ZU2ZmNIKLPLraGz6fFW02Ddid96Gpg9/qxAqF6TKBJq4nZFHLb+YV9swXHy1SHBEpJhp4RAhVRDDyGgHL8uFFC6XkrIbgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUMKp8hj; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUMKp8hj"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12732165d1eso6479130c88.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772562554; x=1773167354; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rXmV66Jla5TZHslijFxcnMnos1B3nd6N9xsVq6iMAXU=;
        b=LUMKp8hjMTQw8AZimNFHdS4IVrqaZAHiKITVQNRgvD91npk8DLc3zXYqKGLXM/ojb0
         RCJw/qhP0Cttw8q0dKOEa+goppQdd8NxHp1qfH+BkP4rcnbyR9X7VmfYvy6Ogkyv8la7
         mGtqpcWOY3YtjHnHy5u+n3KrveL0d2AXfYRkQWOZ0pMexq/+GEwp3D0XQ24cCoPE5i4S
         xT0Zv2/53E4nMNG/V7rpgnNtMQBL7bfDUStpM1VHpGVDzpOYDNNbzvRJHx84Q4/2UbaG
         jOWpzASV0QuMW9aa5ebgxGopJsSXxV545L6mOI3JZhkpz6d5ofbfOjYTcgM85BaoKgAH
         BYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562554; x=1773167354;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXmV66Jla5TZHslijFxcnMnos1B3nd6N9xsVq6iMAXU=;
        b=n8vOiI06IHbfUUw0MvGY0oabxm028+7i+3Ith6DDW9aoS+f3Gf6Gz8uiOYROojzKMc
         o9laf2yH0YtWprSi3WuMisOfhSPX5iTpCtlFHu3VL6KpfOzt/8kdFqz1hkTazdFLWySH
         kz5mmuQxlq/ZPQg8WAibhpm//3Mw6+ygXTwwvWJWumDu6rtDDUJrzy+R5e9p98XQ2IXx
         OvXYQlA7jV+ao7oGZQdfPV+VXvAlxzAsIXdZzUwerU1YcXinl8x8pPZApjgsFi0X9okU
         1IsEVvkrh/oNn8JeLbG2uQ1Zwlngvz3/d1Zru3DliHskxwSAwWSGkZ9IWDHs2RLiHbB/
         nVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU89OXx8Z4KdubgMvYr0eB61HhyOEaq/4z9ad5IRpDSsYWfWpj/n7GrY3v6t+ljklvoJcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0A3PW4+Vq8ahjTdEBXZacI472Ibxsm0Y9+DzizfyXYcUVQFI2
	/FVPg01V3VBYz+SXwGeenCmj71IBTjZTF2s1CneX0QG2TckpTeXoyI20
X-Gm-Gg: ATEYQzwmZYtadcy4ZB6eusEqExWIy9k/kbTxgwxLz7QTZkt6lbAVNEK6hL+71wI/dal
	fuwLCkLfLQS/N9bEWzJXO8ulDWjbH2WMQ4Vy4b4rCygSVySvG8cRGpRdxQPBKRk28P/CI7h+fE7
	A7SgPRNugg/iYRPgsEEw82yCNISnflxLQQ8QJKpfvzXtvZXWxhdtSvtex1QrpnHyHZMsqBVjdyz
	hZ6sGYhQAVbNSd402YPsS3jNKLJ46snljFks3EMASxQDTQ68RbqarEIlSqHeGhrIuDgllf+lT8/
	gOXONpeOB48DqHm0+8F8EgDx4onN9ohuQu+eR5WAuMzhVDkuYDxX1RiI2FJ38OqVgx7uc+pI2I0
	DDeUEffc198gjxg1GYLqetLlgWeKynKLlu7kdCLZM2GUiuL5SvEhjp1NFWAHlMAmtFo7lzDZQpn
	LWcdh4u+1tt2P0ejwDdsbVLXqh8bTED5GjqRKOp7/2szyxoQR/mzEamzdCG5oaByh1PsAluFexM
	tHhXRy2IcxV1mZDlsI=
X-Received: by 2002:a05:7022:2524:b0:127:148b:3fcc with SMTP id a92af1059eb24-1278fbf1940mr5917750c88.8.1772562554127;
        Tue, 03 Mar 2026 10:29:14 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43c12sm18131682c88.14.2026.03.03.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:29:13 -0800 (PST)
Message-ID: <03aec17f262c5c9f1d8b2d1747b2c795a93db7a9.camel@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for BPF_END register ID
 reset
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn, 	glapt.pro@outlook.com
Date: Tue, 03 Mar 2026 10:29:11 -0800
In-Reply-To: <20260303093956.395076-3-tangyazhou@zju.edu.cn>
References: <20260303093956.395076-1-tangyazhou@zju.edu.cn>
	 <20260303093956.395076-3-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-03 at 17:39 +0800, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>=20
> Add a test case to ensure that BPF_END operations correctly break
> register's scalar ID ties.
>=20
> The test creates a scenario where r1 is a copy of r0, r0 undergoes a
> byte swap, and then r0 is checked against a constant.
>=20
> - Without the fix in the verifier, the bounds learned from r0 are
>   incorrectly propagated to r1, making the verifier believe r1 is
>   bounded and wrongly allowing subsequent pointer arithmetic.
>=20
> - With the fix, r1 remains an unbounded scalar, and the verifier
>   correctly rejects the arithmetic operation between the frame pointer
>   and the unbounded register.
>=20
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
