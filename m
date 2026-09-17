Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B42E7387
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604173; cv=pass; b=WGZIxHf2LiDysRZ2RRgffYKG0TNMpMv+2R+wkxN+WKDOfAcvNZDwZciEKwlU9DPJKlUWMhn/9oeexWmNdrlJ5G1pdJGiVQ+2BBe9JUuK3PYEpfmoAEHchsAjkVLT70ppRqX9pADzR8ovEXdFsQZLUGdzcJtVy6mzzj94hsOHcSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604173; c=relaxed/simple;
	bh=cgCjXx3K3RP7szH6oXHAzOuTHiiOc3rY/zqo1ag03oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2NzQTQfNp+wXnCLtEiAEDeWtcNYDfwdFgMsH4kKggcxs7GyxMJ5Milz7q8y+RyrqLfhGRyp8uOFVc4CXo/I6HN/TU3MlR42dBMOdnYAwncdmbXRAlQIKEdJ9rh5CfQrfdkNCsZUTEd8510Rz7G962x2R3M3RnbQiG7NxVSH8QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=nhTKBTM4; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=BCTWSVIN; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="nhTKBTM4";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="BCTWSVIN"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GN3WXj1494321
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=RaIbdgMlB19B5adpmedXkJqWtUrLLVbpjxw11VnXayg=; b=nhTK
	BTM44+ALU1tuKXlKTFERSisa9n6k7dReMIWIu4JoFiVq/0W1nCQCWHzj2zjtNItb
	QVFBoKFrBjyYoxCBgEglFVevAWRf/ZyhO8xVGzaFnE5wKa+LICMa2dDA0W5dJjln
	z2DqlxiFT4dvWlNhXJsGCH+1OZNG4A1iZPqXjqiSZ4vA7wE7md66i0vYFo88RnEo
	jhOtQSOOmkGzGBS6E1o59cajQSc8zm7sdNZM/XFS3Z/vcZQTqom4ItzbCHYPaf0t
	yEw28cEy2LOHoE0sjkcWaZF0O6QtbCpkJskN/EjZFOVySAtxpJoFaJdwS1iFFgSx
	YvvJaBuGmzW6uhpuAw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gqyme1jcy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:03:31 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-893845c4924so1323217b3.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789603411; cv=none;
        d=google.com; s=arc-20260327;
        b=IgnBUwA97r6b4uuElYD7yNVA143TkcSxw5UjZWJBH29Cgk/KpOKx7xgb8q28wAv7zH
         lX25oQu3qLfcICAsRQ06HZSEmelKG1spY1JwWjwp1QWtYwzWIzEooRf60Tl7uBUt87Vj
         AurRHWajMtYSAbuwZgQFxGXmqv5jW28MexyreGvwm7BKqoU/Q+bC11dzApEsnKAA8SnW
         h4KSWTsdgF7dN3RvTV5mN799cK7irfE8MezDm1qxkhCJWlQKBB2zc/WrxERDIT3y5vRY
         D7YTSPMjB0SSdeFClWDZ+k2ad41wKiZMKSaoSBIXWsDl8PbgC0qhSZ38Qxzeyq8Im7IE
         WGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RaIbdgMlB19B5adpmedXkJqWtUrLLVbpjxw11VnXayg=;
        fh=qt29tRmMv9RTRwthwC9TubzTxuwxPM3tixKceu/18cU=;
        b=RsG85gVhl6KjDabfdJWWuc4mxPwfxhTfWr7gJxN31a+ESvUdgdZb5ceSTMta/JNWLM
         W6zpxMXSdH5j0GhrWWTB1frriNuSL0T4FNRSNpmQHvwaeIOK4l9trfLEeho2RQ5aowVF
         Vm/iY8zeuUhuywG5BIJtzBu1p2dpj17nsvMs6oWWUIu3qzkr0Ey/HPhfS0ksbKOKoP7L
         aDP9m4Xk1L2I1T70qora02gOMVCz1DJJR7Qe2xmiCNVn7aN8i203+btgg7ERNZE27io/
         2K6qkyVGLNgb6H9Tb/nPnKVSUKpwn/aLj6bPSTd2BySIAsMzC5PoVWc/tZ1Ig7EA4T+/
         rVBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1789603411; x=1790208211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaIbdgMlB19B5adpmedXkJqWtUrLLVbpjxw11VnXayg=;
        b=BCTWSVIN6OstryM6ePdxkhnS2cHR44/x3A37tMctkvB7qfgYq1FHt1EwDuohvp/Su2
         1ANYxu1sg2akv0Jfe7tGjkt5J0DBND6Jf7QkSA505Nxl+8MIXWRxoyJzgSHS203voTvV
         3MIgYutqfLEyGSKWqTOuBzd7lD8kFXbRd1GeQwsPd2QwPm4U3eIZPbqv/mjK11NlWeCX
         lttPssLSsr7RoFfNLAAa/a1Xwp3gHUPRB/QUa3afkd33QjPoey6xQSyuErID9kgUStTb
         TdUKUTnWESCo4NZjvNjfpvqsAohX7zx6DoLS69+17pOIUpwUZpa7I89hI15gs8VrexNB
         Lwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603411; x=1790208211;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaIbdgMlB19B5adpmedXkJqWtUrLLVbpjxw11VnXayg=;
        b=MLBajViMq8uPTJihJslzThVvGBjMJ8LKxwPWl09zhHSgm2jqnxUXGe7SrAwARj3XJe
         lLRRyJab6jNS8DIcxsa9UhwpG+DVU2e5CWgpZ4s/FFhBf/QgBl9c5FfAoi3Ga1VSUcnS
         xORehhK5XH+zbUOYm9PZbW4ITAVppkLGvkThGzzG66jEiAMfcUgguWy+SQPgRYjPzQvG
         xOGRyiyjuSjEv1ktKHFW7VEKo1t1nA5spzWEb4ccYcWx/jE2+vHRoESS/hfubd8lIBtg
         5ubtGtlbfzDn2P+B3wiaH/vWrL8FkVDy5PKiAifEqLJScLQj3sJLOh9asTswzUzH+3Tc
         Dfzg==
X-Gm-Message-State: AFuF++mNRbcmo0NAyuhp/+uIm+IQ3ogv4+/6cIxYnd6kvw1LFNTBasI+
	CKzH2KY2KKNi/RoQlJwU9oXBfyap7DF0jwnuYqlb1zWFxx/hhGEZmTAOjzzwtVFQoa2euNzfrTN
	3ou4ToHuE8kC60kz9T0NeSG8wIRC//MrK02oByeTnQrTRFzqUl+CRQC8L2kZqHJzIyBNMDzdIyP
	obTTG2+rYUi/D6otZN3K9ceSpp8clx
X-Gm-Gg: AYBFou1pSl4FP95fgr9smD30r37fs1IGQkjJoy3hO429kNjYfzPj4qhh1Gz1YZs/oKc
	nKvpV7F5Z6Z6uhvTbjnZij6///hsMmU0kR62wflOkXNuCdEfIvVzeHOml4HT9DG9JkveAQWCOqB
	xfcm3hY0vaJmwVLOb08PKlKQ83vo0zKnXOgOOmUrMUhi8WVi+2Vluf8BuXhg==
X-Received: by 2002:a05:690c:6d82:b0:81e:45a6:bd5a with SMTP id 00721157ae682-8921abea9famr14218817b3.0.1789603411114;
        Wed, 16 Sep 2026 17:03:31 -0700 (PDT)
X-Received: by 2002:a05:690c:6d82:b0:81e:45a6:bd5a with SMTP id
 00721157ae682-8921abea9famr14218737b3.0.1789603410553; Wed, 16 Sep 2026
 17:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-4-andrey.grodzovsky@crowdstrike.com> <CAEf4BzY4WrknceDP2=ZU19RkPgWcS5siFVEoGqDtJN0+XBSgSg@mail.gmail.com>
In-Reply-To: <CAEf4BzY4WrknceDP2=ZU19RkPgWcS5siFVEoGqDtJN0+XBSgSg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 16 Sep 2026 20:03:19 -0400
X-Gm-Features: AcwNN1WZJBZpIqc1n-oUc8ozyek4qWEGgIztWxIE2o0z6NqzWs3ElEVvEmXs0Cw
Message-ID: <CAOu3gNjgDOA6AOrA-LNPE=hVL3Ob0a7G8fKZJD6SLitTpEe1bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Convert bpf_program__set_autoload()
 to load-type enum
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: W3VeDYfuZAv4Gdw_rwWbs-wp0vTo4zUl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMzOCBTYWx0ZWRfXyrGeQ6w2PS0R
 qUc23GV5uNeRlAow0LghcNnnXk9Mi7S4lpidPXBRxutyHNTGhzUM4y3kAhCk3wEJPv/NFzmwuAW
 YrnMg35hA7mrYu2Ikk7i23JIzAuQa++53m2lqcvRgLmLqRFsY7JB
X-Authority-Analysis: v=2.4 cv=R9aWitRX c=1 sm=1 tr=0 ts=6aab2e54 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8 a=VwQbUJbxAAAA:8
 a=lstlNKMIewn5IdpEohIA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: W3VeDYfuZAv4Gdw_rwWbs-wp0vTo4zUl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMzOCBTYWx0ZWRfX/iKK/h4P6PG0
 05tCqCusMY5DOiKK/LisMirwcclBew/UK6V4mjGjVc1Iu7SlIhoh/YbKJhauoJy/+OfQqJm13OF
 xj0ptY8RZcj9uEc6yWhkmAwmroBifKp6uCd+C9arXtusrBYavi4yXklEC69dVtRAPpDWYiZLjaJ
 jC9BUT5UD330QcI5fHrkcBhd+Z+JiaQRAYBLknY4ZrdYuUXvR6/fMxg8jI7rEGJ3EU5XqkK8zMC
 F8FCV+cUS67UsbBWc8Pb7sQh01FT4UTlirQ8Os2zwqAcMQ3Jzv0taXffGFFo6abW7w4TxnfUCpk
 Oh5MX/Pqyf+lZDzTsUv9VaAw4JJtxtKUIQ2VHrmDeBTGdL4yseTPTbMlSSaU3DAVg/dEjBTpnuh
 9K0TcTL2qWqZZM4/rZONwdX6vVlz2hYXYeHks5+aspV0BhJ8wK0ZdClVsIH5IRNeI3mesBYXuPb
 9NR3cfSRJkz8Y7m0GNw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11907
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160338

On Fri, Sep 11, 2026 at 7:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > Convert bpf_program__set_autoload() from bool to enum bpf_prog_load_typ=
e,
> > to unify the API with the new tri-state load type. Reject
> > BPF_PROG_LOAD_TYPE_DYNAMIC to preserve the original autoload on/off
> > meaning; only BPF_PROG_LOAD_TYPE_DYNAMIC is dynamic-load-only. Also
> > restore autoattach when leaving BPF_PROG_LOAD_TYPE_DYNAMIC via
> > set_load_type(), fixing a bug where a program left dynamic load and
> > became autoload-eligible but never re-attached.
> >
> > Assisted-by: Claude:claude-sonnet-5
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 29 ++++++++++++++++++-----------
> >  tools/lib/bpf/libbpf.h   | 39 +++++++++++++++++++++++++--------------
> >  tools/lib/bpf/libbpf.map |  6 +++---
> >  3 files changed, 46 insertions(+), 28 deletions(-)
> >
>
> if we go with bpf_program__set_load_type() (or whatever the name), I
> don't think we need to change the existing API, let's just leave it
> be.

Makes sense, will update.

Andrey

>
> [...]
