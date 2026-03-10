Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FB3DCDB5
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179958; cv=none; b=l5kCpCnX2g+FQBfnCysrLVHe0DuIUV36oGrwYkXP2OWYQFiQOKMGtKijji9eWl7YkXp1wpH426Aoi+6DVHgcjb/aW7ZZ02NTTg8i++EKZBxM4LwMHe+/oXSAUzTdh1DyiAjj3mhq8DiqVHhIhRUMv6tnhi0nOUwMXc6qd45bY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179958; c=relaxed/simple;
	bh=hKdyWhRhCAkbG7E8ZHtWFXqtf4Qe/ei7hy67peNpqNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2id2MU5vfTfRalimnhc8Rd1SlSvI435F143jwH/zJQ0LXdzwy1CUkZYMXh8th9h6EqG91kZss0mTC8OPWR8ueMpc+sTWonAW1a/49xgSDZVj2DMaIJwIiDRsSCGo04yID08FFuHLos9Z9MndTuI+AH+TMEVQkxe0lV3KRr16fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvDF5ORZ; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvDF5ORZ"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdfd129c52so9580858eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773179956; x=1773784756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NxyfcB33GE/k1PDLeg6Kuo4n34bpOdFO2uouX6LZt2I=;
        b=RvDF5ORZAKOWIxiwK6acc9j8Dh4MUwMf+1NvO0RNN9pRVlkmN3UZf9vB/eGSrIbYlK
         SruJKycc7VFyJc+oytiQdctvc9CVCzSmSay4xypOlNFJGIDZWm/1jnZluSdaFpswhe7r
         akdFAMYmC+RZ28viNco2b7Whjg/Q8u+cjpuxXZh0siVCg+MIoxxrg9nsloFY/7O7YbSu
         gstyfXH//+OPhEbh2/t2XfPSqLp76OzpsCSCLzMNCWAC7XO7iRDwPaIf7MT6iE7c+Mpq
         Mn4C/DT5RTnVKjcyo8egwa5GMg1jXcKOocs01tMnfS/neffylrbVOipKkQgc/j8wffNs
         LDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773179956; x=1773784756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxyfcB33GE/k1PDLeg6Kuo4n34bpOdFO2uouX6LZt2I=;
        b=qy0utffsEbNaxDMDnuhwJeLyj14karR2ivVcv/k7VWQfMNtQwuOlsFx/jQcnx8nzDR
         BoIlO3iFHnPeX8HdWqmHVXL5vHxee8fk8ibvEYRm8TfUcK28ntWnEhFDAD1nndxKibQA
         +/GnY+q7N1z2oDWiUwL/nsPVFxasCA9V39/OaX08RP/RSORzomF9EFVDGhOfmvj/o1gV
         93oxgu+7Ka2QizORw882ivxpl34BwpOL10l+MBJjIrWqyv8dyDhGP6ycneS3pO8f52kZ
         Rb34d69ZFxvvDKNJsw1Ogoxv6qptph5LLeAnd7WU2HAsQZMTPvBWhH25fHAKTkqnGAo5
         Ut8g==
X-Forwarded-Encrypted: i=1; AJvYcCUmdIJp4L5THPKWpOKILVfXBz6EHMYxY0S4wlOF6GyyQRi2kko2Wm3JSiV4D+fqpsi6L9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9MVyOScaIHpp6ETomRddde6wl8SlBL64Owp4pJvNyjmoKOCF
	3t2q8na1E62CcBfMfZjHhLmmcRXZAq2RdDZGy9DyfzmHincLgMdDwl0=
X-Gm-Gg: ATEYQzxj8W9t0akelCDBxl4qT/V5UHHHF5zfd/qirFRrN5NOI7/DJQorWhbcYUWume+
	9vLdw2ZKnjrqh81twjgfu3VuFLo6ul1VMpPHyGTPmKM7+DqqnyLokihPHxMetldP9qS6A763qFt
	OQZUnQ+LYrGovm1odluxQ93Gcf8dnPKn0t66RUozbMUNMizeW5H9vxPUyz7EZGvk4fVMiUsGVRs
	5dzrDxWIVmxyCDjkIYB0j8ixXzKDB4YCwjwwjhlO9vpRn03jgyGbHGb2xQgQByoj32yeAhebIS2
	x0x+nALEtWblP9PUH83Bio3Prct0HaU3/a8/3KkqqRQv/rqhOPFf6i8Bf3tiXaSh1qiAY3Akc5z
	LSIS/wtnENGWgejaId2DEhIy3NfRqLE8BPzAvcnH03QYBrHMxoSQOW7vs177mduPROYmvG27F7B
	sS5splo81iyNzai+If4W1JrWmwT5L6B0Bjf9jFqN2MXHqnazhUbUEgmypWpjgqwLhHju0/j02fw
	gBohQsAR0rLFZSd0w0M6LSnoeEA
X-Received: by 2002:a05:7301:2f88:b0:2bd:cbc7:16e2 with SMTP id 5a478bee46e88-2be8a272742mr100548eec.13.1773179956335;
        Tue, 10 Mar 2026 14:59:16 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa6a15asm127327eec.23.2026.03.10.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:59:15 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:59:14 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next] xsk: use __xsk_rcv_zc_safe for ZC multi-buffer
 Rx processing
Message-ID: <abCUMtO8Trtzs23d@mini-arch>
References: <20260310133024.422464-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310133024.422464-1-maciej.fijalkowski@intel.com>

On 03/10, Maciej Fijalkowski wrote:
> Commit f620af11c27b ("xsk: avoid double checking against rx queue being
> full") addressed a case in copy mode, when working with multi-buffer
> xdp_buff, where we were peeking onto XSK Rx queue twice, to find out if
> there is a space to produce descriptors.
> 
> Adjust ZC path to follow the same principle.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(build bot seems to be confused because f620af11c27b went via bpf-next?)
