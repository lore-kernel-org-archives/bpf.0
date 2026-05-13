Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF037D11D
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711456; cv=none; b=qCMakaxWrWdJQ6a8oP6DuLhvI2+4XmMoe0olMfvfLDGI2h1YbNPZEiZOdqqEicEwwoWuhgTptJ7h2NCfF/sRBEw9YJMVbM/XrEZ8WnfsqnH471SwxOHf/6HzVKyynNjRxKF7BiJ8AOSEIENgqTG0Xm9XEV+MKTFTBciu9NwcO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711456; c=relaxed/simple;
	bh=BdzeFnM94A7uHGNdIfZzoHy38lcfwYKhB0qbIcZ+fXU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knQX8GVDj7CFWXXiISaGzye+z0i4xnpEqo4wSxSZcrhSu1cooWKVBMdw7yybi9UIi/JNDIwoFcnj889Gsv3zjCAsdRGM0L7Hy6c1yDZcy62bKWMVGIMRLaabw+WNrpyArRJf+TsuUSMHOoQkB89WX/mvBrlZ48Ldb+80HJzkUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfe8pbjd; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfe8pbjd"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-132c338a537so3243711c88.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711454; x=1779316254; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BdzeFnM94A7uHGNdIfZzoHy38lcfwYKhB0qbIcZ+fXU=;
        b=bfe8pbjdwGpPsFP/YbR9x7OV4+uaG07u4svh8xJxDLAJUS2cxfJC15ZO17zAp8fIS+
         RXFR3vaeB1GGA99jy8+Tx98iGZNkS5xeJx98nVyw/tvAdzJEl9DFIHj2dlqspo7k7OBj
         Hc7MPMwmaJU6fm/ToWKUrOkykmlOQ0GCt+qPz76Nwejw+HL34wZLBSJu94AK9DT+boW3
         HjP+w7Yq+hkPb0JVMD0oPu638TTNpNpIfmrIHVDib+t3DRVN9VD4jMQtThr8OuJegbVa
         qd9S8or9rPFMb0sjPDdYb4R4tf+jtX7a0BVRx7PSw05tjMt88Vzld/jn3MvqFLiMamIg
         qzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711454; x=1779316254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdzeFnM94A7uHGNdIfZzoHy38lcfwYKhB0qbIcZ+fXU=;
        b=G2LlfLM8AUienR20hA6s/8La3uT6cR+Bj/ODD+cLKzzSO6Rx59YuMpX8qKClzljmK3
         GsGlfN3H8plLQWLuwPP5wQ6akm3FsEi4sPgIrbp0JRvhbKBPA/Wl2Nma9TeCkySdq0P9
         RP/e6xm+f1ySPuCuc+eDds07xZTDU9gwDjUCg0WphO2stJcL0c1eVPaXTxKKIJYxFIy/
         HxZUhINJqyItpTNjXRN2qvu0Ro5lcOhHHBfSCR6qNQrllT+xq3CAAQqp0+4x/mznvMTs
         62ySukkVfOwWUl+SsjIxhSInxVbslbTT9TnerlH+bpkg8BXbxExre7Qscg2O0f+TCKRJ
         Hg+g==
X-Gm-Message-State: AOJu0Yy5h9kKnKwK7xcYo2cYW76eeJ2j5yetsBMWXRbSIMu5NS+OHHoI
	+ufGB8cJeWay266b0hz4wwBqpeqVLTfW4Y677vVpQDDgKJxkYiaF58aJ
X-Gm-Gg: Acq92OGJHoTdcxTwSRts0eL1+BukoP0mijkS1lTdk7m3O1uxDII8TKwDHl9NjRXUqvx
	oXNQQR/3s8XrVPtdV5Nc4VgNsxFNGHh/FtSN80L5m4WmcdWzdgiSSCacPMzzsHwF/LdG+hhgdWQ
	y0schNvtIPC9s/lWVpneFAztUariXECdR/118USgNXOWxA8Rej2fwfw0V9oE4h2c8zFTQEP9fnH
	6nnsNbwNg9WJyWZ9cUTufi5II2LnBySQDw59T+eyZI52jFJXFhJ0S0cRACVsjnsb+5IK9UjSP81
	8rxuj0YLWBTpfJDbgKJlHXcb9ur+IiU4HP5Q/psYNVqyuOiZL6VZSY5HnxDy+JTg3vmXYdVjM4e
	tU8S0LvVHBcrlOskIOfY82N7IFQSqPgPiQMJXR6Bzc9twPph6tO8IbnMGDpEJJCVg73EBbQq4aj
	iU1o8TTMXVTlvXlsfmGfu4XqmmTAM7ygMY1zWDmRT+r/LoBpx0Qj6YjvoPfzi5mRaWEod6RZIDI
	jtqS58=
X-Received: by 2002:a05:7022:608b:b0:133:52ca:7dcb with SMTP id a92af1059eb24-134c8b337e3mr793467c88.10.1778711453723;
        Wed, 13 May 2026 15:30:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm1177799c88.12.2026.05.13.15.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:30:53 -0700 (PDT)
Message-ID: <38185cd5ac2c6103ec5af41347c5a76239bc670e.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 1/8] bpf: refactor __bpf_list_del to
 take list node pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao cheng <kaitao.cheng@linux.dev>, ast@kernel.org, corbet@lwn.net, 
	martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org
Date: Wed, 13 May 2026 15:30:50 -0700
In-Reply-To: <20260512055919.95716-2-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
	 <20260512055919.95716-2-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 13:59 +0800, Kaitao cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> Refactor __bpf_list_del to accept (head, struct list_head *n) instead of
> (head, bool tail). The caller now passes the specific node to remove:
> bpf_list_pop_front passes h->next, bpf_list_pop_back passes h->prev.
>=20
> Prepares for introducing bpf_list_del(head, node) kfunc to remove an
> arbitrary node when the user holds ownership.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
