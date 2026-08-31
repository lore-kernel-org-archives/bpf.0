Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8E3DCD83
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168374; cv=none; b=tZfcqMabq9HbgbKkPVIY/T9T+GzbWvLSV7WqR53HP6dRirJUVVv34KGY4ienNMIEKrqJ1mLF+VFnox5uo7fa1zw0Ln3WdjAQGSlIR13qBz6FY393XBe/ZaSp1jh5imTiI6igmdMO9RZHLL0NbgY0NXNcN//pWHYa2c45BjHk5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168374; c=relaxed/simple;
	bh=ttK06hi5jQ+IygEkiO3ryeZPLThCrdKZVEsLhx+wvL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tij3gEK6cQVg5lRDxIdhxBHOSqFKRDjMjkKmhX6vUNSMHufZ19b5CFyhWagHea34AW0nuIv/AvADTs5V/1498+bk7N+n+apSphWPyP/9bgN3mDd0ipL6mT3VC0QGUB0p6OE9perZFb7NH3SXR4axkRsGoJvQ55ZS+BdYrjXiWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VANmq/b5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VANmq/b5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so23175175e9.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168370; x=1788773170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ttK06hi5jQ+IygEkiO3ryeZPLThCrdKZVEsLhx+wvL8=;
        b=VANmq/b5SPFwmhLEUOe5BJMyaWJRU1OJXE1jypWJCJkwYnvewQv79TVHhBqaMnOy6q
         VqHHyn9qrMVEdQSrnH7ielKq1sXdg8SRdlDN7zxs5hKTc9Ikq8frg53gEKQggkT6oVia
         mxU0a6IgAjQu0I+sjhvvoUHOOtLPVQfUie9HnBT3r3UmQqe2wHvP7200YhhHMBWI8Ty5
         e2WmQeSAyHHbunu2GGdTcVbSy4TnOVGRXFr0nCI63CPw13uT2qXTUfcmPdj/iPmZI3PW
         rX67T1e5+WqQPTxxeh2qG1q3gTaNYXeXTC0y0BGmb+9vwbbr/ziodoFU5LNbKdzI5aa/
         7FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168370; x=1788773170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ttK06hi5jQ+IygEkiO3ryeZPLThCrdKZVEsLhx+wvL8=;
        b=UsOQeq3m+fi9vxtOb8sw7HjtRQthgTrvZiFbwnIA8jONixgvFTEnFPLf8lfaSG0XA7
         Gb43lR/C58nECdMCZsmGRa2vGXqdhIuNrCoqsgpIpVcNYQmvCcHnr0bZIldqnafsap/Y
         yKSzZueD0MQftEr6FiPwkXqPawW27Yf+w4GqqVtStLbD+159muJ57j/sGT0+M7S+TcUM
         um4heszjfJgSM/LiFTxXz8SWTBqRwJI+G1u5eI1EGt2SLKd9gNeP3qIcaz4Wd87E5/Cv
         U2MId1jzT0uSOEoJaeqMIVFjVkslBEt/cWk9wmIgII1/tyKSee6PZQUoaUFGigRIos0v
         8+mQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6Ma0L3yi4PvWot8kPuaqD8OVqYINTUeqk3ZvtOko2SS+btALAagmYJuA8UToImbm8z5M=@vger.kernel.org
X-Gm-Message-State: AFuF++nvTX+TvZM5pOgmxXHtrg9nv8Z0whz5T1DeasqTbWNrpUaPfRFJ
	AJZMflKSQhuI5+qvtoKwK9620p5R0MLQyYkxweWL0KKW/JR7wqouEyw/
X-Gm-Gg: AR+sD112QL50DNJhLM5A8dQxVXn7/ta4sd+r7VvewFoe7UY9C+tf8W1P3XbScOoiN7B
	WhwixuBB2s7/oqtDU6t7xOoiW9/Ku+a/E/bKTYkg0iPX35AxequrzuZJHFqI81ns3M7TZRN1NE6
	xzP5NVzNsNfBk6MMXJ7YnfYSb8JX85aqRfEXeGIUVJEcZdECM/IcHXgM6aKtkToQvWgnuglSOR2
	7vBrVs4gYXVQNwiKofBVbYD5ngZ0igVMN4oWrvDQjjNhk/xCa0p0jUaa3Ovx5o6tMfKy7iEBH6T
	oX+V8m/10TDVzpa+DgEKgdocMNk9o39sXutFJocOicaRdRigaxAcRkfs2f4mcRlf1aym785El/D
	AuWWOkRYElxMsjYBhGDADp8v+NBjPSOHtZfNwKOzPYDH2zJb6uDtIO6044FUoimK8mhP2QDyP+m
	QKqH+gNJh+UDoMHxj+lAFhJ7tNkCswRQ2NkeDGyOU12/FKwz9FaAzsqAnVGv0U657aucXkACh/9
	Q==
X-Received: by 2002:a05:600c:8b35:b0:499:cd34:f7c with SMTP id 5b1f17b1804b1-49cd9421bfcmr29162715e9.5.1788168370027;
        Mon, 31 Aug 2026 02:26:10 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49c5a903eebsm171374105e9.4.2026.08.31.02.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:26:09 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: andrii.nakryiko@gmail.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	tasos.papagiannnis@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next 2/3] bpf: Add user memory access kfuncs for linux_binprm
Date: Mon, 31 Aug 2026 12:25:47 +0300
Message-ID: <20260831092548.42348-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAEf4Bzb9szFTDo5uUxLgUVD3qA1XF-5A7GZGxJjX6d1MYLhbFQ@mail.gmail.com>
References: <CAEf4Bzb9szFTDo5uUxLgUVD3qA1XF-5A7GZGxJjX6d1MYLhbFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> this is probably ok, but also we might want to look into having
> verifier still allow to dereference trusted ptr-or-null into untrusted
> ptr_to_btf_id to help with smooth transitions like this.

> Not sure how complicated that would be in the verifier, but that would
> be a nice backwards compat preserving behavior.

I have just submitted an updated version of this series that also allows
to dereference trusted ptr-or-null into untrusted ptr_to_btf_id in
https://lore.kernel.org/bpf/20260831092305.42062-1-tasos.papagiannnis@gmail.com/T/#t.

> But to keep things simple today, I'd just mark that bprm->mm pointer
> as TRUSTED_OR_NULL.

If you think v3 is too complicated, or that the trusted-or-null
dereference support should be split into a separate series, please let
me know. In that case, I will simply mark the bprm->mm pointer as
TRUSTED_OR_NULL.

Thanks,
Anastasios
