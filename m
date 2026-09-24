Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55B147F798
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245392; cv=none; b=OsWo0NAv9rXnF1YGKqeR0sUtzLgBKMIxj0v2jaHifqGY0W1dIWOUdlcdI9p6ip7hgv4q2I0oDTjCuwMSLIy4PlQyyOZHGVjKcufaaJKtA72Twa1GBo7LSSqgWv9gNqqhen/eqnp8Bv7lCPlvby5J3rB9BN/sKgHP6mJNEe9f6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245392; c=relaxed/simple;
	bh=ubDIQFEO1MIByltj3HjP+uhGcS5vNqWz5d++LjyFrRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAT02ERosCbz/ERS56ECaKqap8IKUfDyQIdkw+uC8JCQNsYiABFPAfFgSmPYGb6+vKMcLzd+xbd/6JDlRmNTnz5ognEbkWtVbFOmoMcYSUa6jM7nktrg+AGQ8B2RBhfotqLZBr8Rov5h0Ul1bHc/aHks1heh9V13k91dm9GpPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgjNqS/V; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgjNqS/V"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso1351905a12.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790245390; x=1790850190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wYegx9gEg7NXACHA1V/J0HHo6A6tOLA2/UcguWdtiq0=;
        b=WgjNqS/V+MEVF3oj8o7eohfNXBLvsm9SIWgIUAFwGtISCeh+vAu5YOlHcpt0uO8Gt1
         UGUiz2hw74rIT4dQ1rCfTyu9zI7EvbNWf8R9mQSfysOJlcxoHD4aJ55zj3w/lLWLNwbg
         GD7R2+FZH2NFrr9cvtnRhkIS22i0q/co6tO8mdPyPcoJ4OTklhKLx0Bgu0O0dXFP0mCd
         BRWwYrDb5l7WIwfi97aMUaiGO5gA/+GBNOr3JxaXkdyhcG26G2O1sHBSkLHlosFb0Usw
         fXszAtFF4RIHq3ugoQkKDnT1eTY0Uj0tblUm87fV5uSBEhgBk2h651mWWGF4t33Sd3Up
         1+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245390; x=1790850190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wYegx9gEg7NXACHA1V/J0HHo6A6tOLA2/UcguWdtiq0=;
        b=CK3HYzWGxMiWgOQmOy7/2jNDywq5WF0oBhuxdeHCR4HtZafyX8boyKwEhS7PvbTKOD
         vqvLzhof0b4FMG/W4UmKff5iEp3ws8Nf1PXp5iYBGHL3GlQaFX+axsNHf4QsXCEriMDg
         q5K/2HkJ+5wBV/ecRgMWKH/usxqZ2MWG/vHiMftdQO8cCpoQBj8hk0ZpjJLzSF/yoIzq
         5nyl05gJ0Pwf7tQ7CK23ZOxE8tpBXAVTf8GAGb5EHC491Okl/Ovwr6yxiVy6ypn3fK+u
         r9YuMEdGdNtj+Rt8JL4JnYEduQ3GH4eL9lTmyXfPqfzx9403ttutmz/3T6fDh3ja7FBz
         4JFg==
X-Forwarded-Encrypted: i=1; AKwUvBwEdynbhqZRLFKIXZ1msO2sUm/coHF6z/dPit69LY31Mt0nEgKYGrORHm/cL8+zp9CLIrc=@vger.kernel.org
X-Gm-Message-State: AFuF++lb3Omqc//azxWIXKWoO2SXhpbecnLUsMyw3vYszFWLBepKxvBz
	HF5tNuK2m4TKBe6BuKLHCfUS9k9Gz2CtDdzKyLSlZ+8SSZIs+OeSxWI=
X-Gm-Gg: AYBFou0vVMy8LZFuGKh5/kJ71LziTb2Y7qvnomzgp7/sGvlquRBbQCaZgcv2pnZmUJ9
	9rflZfxvW30biAMgVeZY7+kXiwXoMoOIGI2Pt+wbywVY6DHm2/crpxcWAfWU3sdZ6mID4rdbUfN
	tmzS9CLMb0eWq11i022atIwucEWsjDJXYdNLbU3amINOZuvOXJc4XDyro9N4UrIbMz+RDwLqM3j
	H6zTKyQC0Bp7OCIHxvNlZuWDBmtliepP4L8BWFhh0uS8MhOOsGkRiPcBJJEgSnJPyB1J/Ejg0Gh
	oTJGuZLfeS7XIxMB/BlaRx+y1+MijYkYQZCt37CYFXf7WJSN7e3I+NHXeEDjXNYFZDzSV0KLXhg
	5Y0ziHGaqJ/3ewtJFY6BhonvqGhtW5wwthn/DJWMQmzILY8slcb7VKHeIXMunkhmj5ZoS/diWw2
	0SdPJBrYDop1ygPsnNxcM7JQPAYcPhHlYN2PorxRbmEGhmuYLnhjw6kHpzUC/xPCjNxOYFJbm2d
	0/mWMFRQNs1HWKjw5lco2yk
X-Received: by 2002:a05:6a21:9192:b0:3dd:85a8:cb82 with SMTP id adf61e73a8af0-3de0e89f90cmr2113174637.37.1790245389761;
        Thu, 24 Sep 2026 03:23:09 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dadae09sm2668096b3a.38.2026.09.24.03.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:23:09 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	martin.lau@kernel.org,
	mason@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
Date: Thu, 24 Sep 2026 19:23:02 +0900
Message-ID: <20260924102302.2120375-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6f3525ba15027c3ab18ea5ad0b081dc086e758aaa9cf8854f8a61021f135fbb8@mail.kernel.org>
References: <20260923000801.1764758-1-donggeunyoo.kernel@gmail.com> <20260923000801.1764758-2-donggeunyoo.kernel@gmail.com> <6f3525ba15027c3ab18ea5ad0b081dc086e758aaa9cf8854f8a61021f135fbb8@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 00:56:22 +0000 (UTC), bot+bpf-ci@kernel.org wrote:
> This isn't a bug, but could the sentence starting with "Since BPF_F_CPU
> was added..." be split or re-flowed?  The construction mixes two
> sentence frames ("Since ... was added that writes ... so on the create
> path ..."), which makes it harder to parse on a first read.

Yes, reworded in v3.

Thanks,
Donggeun
