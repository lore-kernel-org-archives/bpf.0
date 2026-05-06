Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2548B36E
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080000; cv=none; b=qhA1+jidmJ1KLUZSNdvhuK/I58IVK5aAezrFTywavaiyeQWXa0tKyLrocfvjxKt80iGq5vhoPS2kTfJxN+o04g/u0wqBsPTJxQwXqjJnd1z/Dz36Cb6DlR3znijXknqzLBh0za9y7h6lXIV20O7VBuDLKo44va/TMveHNbtEViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080000; c=relaxed/simple;
	bh=30p2kdTZbNSFKr8Y/mUI5XYXoBBWoiYScms2rXza91Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nSafkDnG1z8jLI6V5nsROhqKWXcaR5XwnO/6ppu1ftR1X/CFJSJhc29Ka5zEuyrr/gUNmpw/HVbpRut8i/o3eWA+HQo3+4Fyi2mJNDr/H1nCdtiRjulcLc9Yz7GbKAQm3oVZk/wAoWSxwrxN5ohuwJKxYLeJeHgRb5J1M8VKJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CO9rEdrr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CO9rEdrr"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bc23bebd345so186995166b.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778079997; x=1778684797; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30p2kdTZbNSFKr8Y/mUI5XYXoBBWoiYScms2rXza91Q=;
        b=CO9rEdrrZNH0QxnJ4E7PkDd4BGiVment7mXArhn++fpyqEO5dAdI77os3QZ2hAF2Ej
         iFeGM9hYxR78TKgethKHLr9o4XH9jWyUoIq4Rvc5fQT9Tht7tqzk0Osatrv7Jpqj6MTo
         4mvx8vq9MTos4DgCgh2wX9pp42IRyqKIbj2nGi/NOpwo5bfKijO5J5Q3PezV1sxUzXLG
         I40+L3Co8Q4Y3BvLo7r8Xspu0U/YxFbz6ocCMYod2xFw1TqdqgutwGC1xX/w6SNVUPU2
         BIqI3aV7R8PfbjHNAJ3s6rWGbcr6r/AgqLQ6A9zK6ZjI+WygjHYyvvFMYgWVlrpjR8ub
         /kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079997; x=1778684797;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30p2kdTZbNSFKr8Y/mUI5XYXoBBWoiYScms2rXza91Q=;
        b=o05CQdqjk2JcbVeZtlCWUOV+sXhdUF8vOdjSInFef9kwwYdjHB4eSfsoYfmF1TgbJT
         +jPE9TrjbSoTpC5ePFklu2+7mD2OR9bpehlzxBKIjjynsF6gOWpKHjKR45JOfn/2NfmC
         4TidZMRrEMmSBlbO1/F7oUuhDzEK95Z3XsTGbQpodz+NBz6N0e5syLUnWDVfsMiOzT1t
         d9Zzb8DEyirZj5zqHYNNVR+8K0yEQjuvgL0j0qWRwtae1d2tes+tvjKILNI2D8NKcY7K
         PzkRhnkbCl8byNSnjPKrlG+M6HferpSgOYbMY/Fx6TdkAS5nPWvnYPQn2F2N+Z1MJ2xH
         Vtlg==
X-Forwarded-Encrypted: i=1; AFNElJ+LD5cExRoVeEpF41cj4LNFN/+VuPbolGdLgW5Z8T6hMdp4wTJTinKbQFhnHfy3HocTI0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzezkyV9Se2dLqLK5FS5sqwanIbgnHG4DKfepBz1fmdNqshwKBF
	NOir2mG40rXH0Tsu/PWR30tkt7SfeQzg1v0Ns8ahH18uNhUu6hwQeOGZtAMjEqaP2nWAkBSESvN
	253fd3TE=
X-Gm-Gg: AeBDievg3r3FG3QlHkVpXtygSR++LCqujH/gOlrBl/FVD1M+V1FlNGGrtLfrMxL8hCj
	yOd2rCoI95xa5dxGrSgcrRf7zLFMz+J54LmmUbDh6ZZRN94wVpr1pbGc6KyJRFm1wn1hmo+egCi
	QyU8GvuPCzGxa8SJZlGmODgGDD+1OM32KU5WX5PxJhRXRsuZlRKTEMJ0VV1DQO/wYf2Gc4FLDDF
	f2B2tqgxaaYTQvyPoAmSlZmwlxU0NRgXxnb/9Enx9kmc5UAGymOCv9LbGeurWSk9+r1l7EFAqPW
	u7SGt8O9DEnG+818MY8zTHHDhHe4pEp+rORoBSZPTY132ErC/pFLl4cQaMAvY/+KIE+Q1XHGDyI
	gQl6Jt0SQ9zd8yTnRnDpuxMiknG48NEAvE0afvk0Av6DL2b0AHp67z9n/bIw1w8fdGFjJ7/Qtqh
	EXwCtGe81SOe3BAM6nac501f1hD1OPTKzNPbv+jnpd+1g/lDEDqsfHT3Kr/ae8sAmXCggnXt4=
X-Received: by 2002:a17:907:a08a:b0:bc6:6af:f4ad with SMTP id a640c23a62f3a-bc606affe33mr99179466b.4.1778079996695;
        Wed, 06 May 2026 08:06:36 -0700 (PDT)
Received: from u94a (61-227-76-27.dynamic-ip.hinet.net. [61.227.76.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2cd25sm30177395ad.22.2026.05.06.08.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:06:35 -0700 (PDT)
Date: Wed, 6 May 2026 23:06:28 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: lsf-bpf-track@lists.linux.dev
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] BPF in Stable Kernels, an Update
Message-ID: <aftYtW_R82qzRt18@u94a>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Slide deck can be found at
<https://speakerdeck.com/shunghsiyu/bpf-in-stable-kernels-an-update>

Shung-Hsi
