Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1E3AFB06
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067756; cv=none; b=WZyZIqsUsCdqT7CE5ZlGxswhF4uvp3AEigYBFDSZhFblbb8T7+V+SRCnS/k8qywWXZXrvlizr2AKid/br3dXH53pI48S1MNND2a8FwLWM5V4C9rUfhlrPvOtQhJvXfkS/3CUdce4Ml6c3yY4fbwqc/89TGJn6A0alUhFhhSSW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067756; c=relaxed/simple;
	bh=Rf19Xsc/u33WjgVP2NLj6qqTmgUhqc6BV1N0Ol7tH4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWMGe9tR1OHqE+ZPAqxJy/vZ9pDTZKFXCfDIycPcck8AXWH6QQHzGRya8TWEgr2mbZMKijzdLf86f+JZHwuiqpPdS2eQP2nHOBsJQAbCFsOlfcILkH5ZSL/WB7xMCxjJS2vFJ9AUYqsXGI0jLAdzU2YE15AspmlWortkyloRbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6P9Ml3Q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6P9Ml3Q"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caced6038eso1837105ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 12:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789067755; x=1789672555; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rf19Xsc/u33WjgVP2NLj6qqTmgUhqc6BV1N0Ol7tH4Y=;
        b=W6P9Ml3QVxJhWPzUNd8RJyo1TuqWkMKTs36y/bhG2tu37lFZ440j/OuiUvjNWHLcSz
         l7JWHF+8icggp8HmYbCH/jEyHu5vbiAHJv2ZhSAvj85lT5BaamrhnPnmvIRcrBIFmKwP
         89fVOgtEu2hEO+wuZXevYBKGnG2oV3Heq9dDcaBJBKNDwGIDtZUYPSG+7Rre+ehEJK86
         mVVAb1w+XIdbb5JwSXhVqQYrqwHYjSos4XZtzKUqZa19/url1uCaB+iree/igDODJSXi
         VCY6acL5rUrUEF31ABCv8mYOGAbbxROzeOjN5qTA7hi1a8SvZDo8YQdzQqm/cnwzRceD
         JqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067755; x=1789672555;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rf19Xsc/u33WjgVP2NLj6qqTmgUhqc6BV1N0Ol7tH4Y=;
        b=jC+E/1Qc02xtgy8pl89XTW+vvto1qh0ijgvUtiZ9eJ8NHCeRtVpUddJs1ix2jsQ6nS
         7ZPWf6J8AlkFbxCw7zEE4Gs0lRgJk0xpt3+Zn7QkmCjwaHBFu7E9D54QnfstDLg1/u3s
         pAU0RJQv+KDMCkOP8a05UGUx+88GIjHVycw9KCeln5IXDcgtQsouyLmYILzDKIHfMY7a
         KfOKhIla2e/PvE4BhtsSFOiHWKUN/CDVS1UkT/0OwiVlMKJb2V/LvmyiC3DfUv6lvvqk
         6m9hYv0+fGQPMFnYjYFCHrccULV9vdH26m7QB1LlgaXFMpBApxnNpPLpb2yYfNMbzaDx
         IFUw==
X-Gm-Message-State: AFuF++nM7DJxVG03l66hZfr8rp+30TibLl/bFZsD35icsybUicEaCI3U
	IzPdtWpkV6UnCKjsJFYwwE/bJvmvdxkoPwxhhHJOKPyBhws121qwMpscwFrSelj3jMY=
X-Gm-Gg: AYBFou0cewWxuDC2aMd8ZuYrm2RtUPmWHGrJIlJ5g/+FUs0fGnw814rdRQkh4EcNlin
	HkH+Qk8dBhoFHuiMLlzYLyeSlQnURks1KnRaaVJLMzF3NmduW5cTrX6ZLNLnAIUAD2hWzaTwCFP
	Qob7nnz1UlbP/1nxVNP3ovM8eJiDDI06q1wk2xcNrsnJg5M+R0XGNw9AcwQc2z6lCjqf6NZ3fGx
	Iphmci8eBDqWjxPTI+W7ZSlMn1ph4u4nAOHtq0TbeHtYLQ3DLSaYyn+6ze+rj0genqbcBQLlM1x
	1KkKYGByuXVNhB/lrWFytI73/dKGyYWcPrvUiuN3RnQeUaBxCy+jZS0CYXK4knx2USUQ3JJokZn
	w6/nElsPOLyKzcyGo0JlwuZucXL4ae4Z/r90RBOwuJ7pJre2eSHqHoi9TIAN9kq2MMjUtYkhrBy
	XOwOS+L+sIBigDSg41kcqbdscATnqzMtdQgVY6CxdLASawC9RuF6MZ+WAfMpeoYhu+F0N8W1gjw
	XYPI354Q6158l+LQL1spejOa+1p7SjFW9tiBSBHOCxjW/MPX2/ODKgfrlI=
X-Received: by 2002:a17:902:e74d:b0:2d7:1b20:e98f with SMTP id d9443c01a7336-2dd0e8a1969mr64089575ad.2.1789067754496;
        Thu, 10 Sep 2026 12:15:54 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a3ce:533a:7492:3ff3? ([2620:10d:c090:500::4:d279])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e5182fsm202796eec.9.2026.09.10.12.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:15:53 -0700 (PDT)
Message-ID: <46e462389445a0fbc005f549d3fdd52c65805fc4.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Clear scalar delta on narrowing stack spill
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
Date: Thu, 10 Sep 2026 12:15:52 -0700
In-Reply-To: <20260910185604.44949-1-daniel@iogearbox.net>
References: <20260910185604.44949-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-10 at 20:56 +0200, Daniel Borkmann wrote:
> check_stack_write_fixed_off() breaks the scalar link on a narrowing spill
> by zeroing the id of the destination stack slot, but leaves the delta in
> place. save_register_state() has just copied the source register verbatim=
,
> so the slot keeps the BPF_ADD_CONST delta of a register it is no longer
> linked to. This is the same shape as the case addressed in 1b327732c846
> ("bpf: Clear delta when clearing reg id for non-{add,sub} ops"). Unlike
> the latter, no miscomputation seems reachable, so mainly consistency.
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

It appears there are no other instances.
Remaining .id =3D 0 are for non-scalar types.

...
