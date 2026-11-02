Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642078;
	b=DQegNq/PyapvTLbKxS77SlgkIpdMsy0qXDLxBZ1i2rQGn79gN7dqGoqZbmrQXFhB81vb
	 FQKlbTITg+Buzgz5DuYRdH30YKE4e9vjD6oBm8OilL/aLhdAA+PekOpjniFgeYAN5QrT2
	 GmCVYBpVoSUF6OoerZGaBXTfNZIlpx+E+9zqnE3y03K6TRY7pE1k1n7uQYiR0aMNtec9x
	 vrHUEC9EHdQg8Hs/9qZPMzmvjvedaECCqKSCB04hryFH1oXW32ZGlDkHtxHawqaKmCf55
	 H06U5Gxas4IBUSPEMmgSNT6puDR6XeIPd8uw9oCiU6++VYt332yieO0iA2rrO+GVNzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=scZeb17XXKm1k29PX4odbDUwJgulUaI/xTz9Vkg+cZk=;
	b=oTpWyox0KfA0YXYRPrPuwLt/NUiCOydI42QCclQbZAVHNNx7HbexP+b93bHkuXEvKRcv
	 v7fRdxwAeJ31o3cQPya3SxC2ubSWw86/XsB6X4b3sTY6e1+hjYbXO7W0nXT1b9Q+oE4Lj
	 tz1JxY9uu4zVDlqNdYX7bm2E0rE/cVOrUo0hqxDF0hQZa5/NO8DRXhqajq5qOcfnR0k/j
	 HQrgUa3l0O9Z0y9qOiglLKy2tvyy3zl9w9F2yqpDL49DQfxl6Yvn8sz2NJGqNemkshs2d
	 a/ukU0Se3NDuNnxRuXrF7HXANYzjMt+kJfR0wBPSDnM2m9THmq55Ej5aPF7/wKFxiyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUUKJZ6i;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7885606A335
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7885606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUUKJZ6i
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1300164a12.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793642077; x=1794246877; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=scZeb17XXKm1k29PX4odbDUwJgulUaI/xTz9Vkg+cZk=;
        b=gUUKJZ6iE6kMeJX2wngFOmJfdj34tHNdukYJ2763/cO78pWzbLpFiKwzNJXe3kied2
         6kOgIXV1pK+gXNCLw7PW7dyddapp/S+ZcVxmvmI8KmVa0VoZ4G5IHs5nppxRYhKPGT7Y
         CXLAw5MZ/pUJt6atuEm+Ut8tbfdqBO8uutAUQDoZnwmkmueSobeQS8dX5HM8wTn402vr
         3wS6ZRFTtpf0Gb3m6ojljLsWlt9sPRQFXyDhejy0lUVPBqlO0SD1ofi3XKsNk3TfQJWy
         TpJPR76fGTxghSMr+8VmSiaWD7DKO/AYuW3IK0YYGNoTMz8CzEs3U9466f6bOQmwQYZm
         GWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642077; x=1794246877;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scZeb17XXKm1k29PX4odbDUwJgulUaI/xTz9Vkg+cZk=;
        b=JOAgWFtQzE9b2kIWeB3++2C18CUgkEMs8So62A6g30pHPsOPFS8HgqjbMpXR2DG4Hj
         +S4yi8T1z0z73ZreSHIeVMVeJaXXDBMRaz6FSDyuqfvKPZinlDV0ZLQon9BMojYrL70l
         z4eMCTtrlCP+QptyX4dxmWjyFr1XuMbcVnSXpEn/9+lgcK8JTDX4Ap4uOWsf9VxBf8kW
         9yEvC1JMNaFFZSnXXsbNQkeu5GsAppUqnh95/AqiuZ/DeiI5zgeysAPNRz5D070EjhiN
         FTlUOKZNqcxQQjR2uwBX0LWQh2SH5scVGD/Cp7iXxM4+qyjBHjQgrF0rVMlOb5H9ccVa
         Kydg==
X-Forwarded-Encrypted: i=1; AKwUvByZAFCFFGdbLNLTSDQX+xjAjNztO/2sWnYyyki1NxAk16g1l5FoyJGgJB7LSjdPqf7xfm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JmqaJxZArbLfTM3Id4PpdZahnChzX6+91mH118JZXU8MqfDew
	XQ4KM8mJE6X6vrNbvJv6sK6zNlSTirF32zNHqc4rVqnLNNsZp7YdrGMF
X-Gm-Gg: AYBFou1nmg7N3t8nKVWPg86DWG47iQXCcyJlyEhk9hNiI37QnuQM2i0/RLH6lVJTXO1
	EDEKxhLu35qGRo0PR+JJXEKvmo7LNktBzrLB4Qft7eSZWByvbG1uJz/sMVWpXxC9YjuTyEef70K
	u8uaHMHcRFH9XzhDd+KoiUC4br8PaFJJKmcCK8KzKqMAl8XwzWgY1s/7SuAUsQXiaZug4aUZJ9P
	KY5YJvj1UuVm+UK4OC34PxVJgM5nbJfrphIry54hViMshgsFTlGNzRNV+qZ5p66mXNC8QNNVpiA
	Tm9CAWQ7My0pHpiJ4vBBjJZFMzpuQXS88sFsBTnriLFJrVKT3AhNTYoWDIiUa5pSJ7wQLindRSM
	oDZij2bEgRO4r0UXJgi9BlAT1hLHEvSEzVFHGoYPnFVKLpPJeX911FRqWWysbAJzJDO7KEnHf60
	qD0PJns7HGgX8o8WP8c1EzB5ycmIDXBOQK/nl2pnovyOxqL344YfqBTwkTtaUUKls2rEBypPWiU
	+5WAeJesXkJi3jM9B6ao4a6wFvg1USWIbj90XJXScCOffBvwluZl6JT6+ny+BC7asueo7qmjp6y
	wPFVsS5o7cA0ZWKge+HLYJ/mYNZWyvExs/XOJd418fXv+wM6tlDbQrTmtlKIXzF3wY1P79mKvyT
	xcwg/QUrqSo/GJa6iiEF2tflOKw1bsf09+g==
X-Received: by 2002:a17:90b:2e90:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3ae898311b8mr7938750a91.64.1793642076815;
        Mon, 02 Nov 2026 09:54:36 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8826a769sm7170534a91.4.2026.11.02.09.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:54:35 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 17:54:34 +0000
Message-Id: <DMKX1TT24BEL.328L6X0AO3CDS@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, <bpf@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Use "new" URL to show if net-next is open
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261102111509.357269-2-u.kleine-koenig@baylibre.com>
 <DMKVOUX2GDZN.2Y8MKLR367NU8@gmail.com> <aujNf7TVDcwMYeLC@monoceros>
In-Reply-To: <aujNf7TVDcwMYeLC@monoceros>

On Mon Nov 2, 2026 at 5:51 PM UTC, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Mon, Nov 02, 2026 at 04:50:37PM +0000, Alexei Starovoitov wrote:
>> On Mon, Nov 02, 2026 at 03:15 AM Uwe Kleine-K=C3=B6nig <u.kleine-koenig@=
baylibre.com> wrote:
>> >  For non-subscribers to kernel mailing lists, there is also a status
>> >  page run by David S. Miller on net-next that provides guidance:
>> >
>> > -  http://vger.kernel.org/~davem/net-next.html
>> > +  https://netdev.bots.linux.dev/net-next.html
>>=20
>> The link is not the only stale part. The whole paragraph is wrong.
>> We apply patches during the merge window too.
>>=20
>> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_=
devel_QA.rst
>> index 4729efd..f6b9533 100644
>> --- a/Documentation/bpf/bpf_devel_QA.rst
>> +++ b/Documentation/bpf/bpf_devel_QA.rst
>> @@ -231,19 +231,9 @@ load or urgency.
>>=20
>>  Q: Are patches applied to bpf-next when the merge window is open?
>>  -----------------------------------------------------------------
>> -A: For the time when the merge window is open, bpf-next will not be
>> -processed. This is roughly analogous to net-next patch processing,
>> -so feel free to read up on the netdev docs at
>> -Documentation/process/maintainer-netdev.rst about further details.
>> -
>> -During those two weeks of merge window, we might ask you to resend
>> -your patch series once bpf-next is open again. Once Linus released
>> -a ``v*-rc1`` after the merge window, we continue processing of bpf-next=
.
>> -
>> -For non-subscribers to kernel mailing lists, there is also a status
>> -page run by David S. Miller on net-next that provides guidance:
>> -
>> -  http://vger.kernel.org/~davem/net-next.html
>> +A: Yes.
>
> Even better. Do you care to get this change in then?

Pls send a patch.

