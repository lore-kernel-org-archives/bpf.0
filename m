Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159D1E8332
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174779; cv=none; b=oKNjLNLNr5vF2rQtUmx5WaxZpn1WEBpv/VK6HyjSUGQ2WkZqCkTS86p1Yf/G+TQ6xpcMyhal8wwHZsARJ4o2NnFnYXoNSwRS9frc7vYWn9HJxa2iQUMqRijjYEyXCu+gATusxlujwG3zDDTSx4swxCSpAf+4WiZab/hZYeEDoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174779; c=relaxed/simple;
	bh=upcwOqTksFzVvwY2xLbduvinMYOV/rJpZ5SFcW3Cl1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7XQ4D2b7DsAl2AjonYFsnAryveYZ+c3m16WOpsa22P8YHqX6UIOWiopnhPtgDKtTamofRapouhfhHjm0fTbc2vkqi7mNJkNjbIz8RtxpzyAk6xueSIucQCq0lgquhLOWUfiNDIJ3lWUUAzRTu31ExO/8i1qq2LcuwdnD8MtG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtHmTyli; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtHmTyli"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c6920so112919a91.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789174777; x=1789779577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=upcwOqTksFzVvwY2xLbduvinMYOV/rJpZ5SFcW3Cl1s=;
        b=KtHmTyliSUk8JyM5npU4YUgxuNqtQ+hKntmtAMNgMjq6qhbleRyXdCEK/EJKLVebdt
         4ZtOHWjQOyNLzuMMVBIFedgCsTVZ3iPLAg68MDdH/p9STPZXu6m+0YsJdKc/r5nYkbLV
         vjD/Kpe9vMykGj/e3TJ2iqUe4tE0W5nWRYajpyqAEwE6ZQNKLSTLgg33IUNGXcGEhNdU
         64lwOXLlvXrvIBk9HyOgJbdMsFaLihup4KbX2Qhwzp3CoN+oztd8aF7TKsd3EMWD11Jf
         rH+nkK18lEcdkAzuGUHaiYTvhsRJtzbWVRo5hghSkFyqnNtt7z6RLRG8I4KT5r7qGWfL
         4jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789174777; x=1789779577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=upcwOqTksFzVvwY2xLbduvinMYOV/rJpZ5SFcW3Cl1s=;
        b=LJNeUwJGR3yrnOJLWD/9/+QSAUCIWkR72UeQPnymfVEBSa9wD7ZpkWY7N5qzGjRM9Y
         rQuwrfXcXGD0ONjyLj6tv3NeANqWAZfYSomwNIZTQuRkA6BsjxPI4ChmSt6Z3RiXvCCM
         g6ma6YWVxh9/jjYWxtlMRokrrXD/OPwEm7ti6tMbu49B7cXqKSTj436XtMjP6OMLdS6J
         6urgHcenUpWs9wuGG76mflk9o9gg9rLM1eJ4IjFKdVIbCge/BptzzT/d39dEMubaNwwW
         iY/jx5Yf+zXdz0hEX8jnNDExcYJf1mc4hTwzpiu3ShhHdfTeyCQQ0+GH/CKpBxmMB+TM
         QcjA==
X-Gm-Message-State: AFuF++mN6RYyKBJVHHSAyTMFreB1MaIDRGflo2cnYfZ7m0/PCRV+NQrA
	yi8DBNJNoS49acs3EKp3tZ835KWgMHLOr/W/j6cTdAemzTM317VnaiUT
X-Gm-Gg: AYBFou0zOiQ/+sXtZruaSKq6A+1hPpSaoNIOozWRCFhTkTtxAVJGvHNLrf6tM0CQrKf
	ZAXAeZACvtGvrbXWbogFQ1tqDPHw1k9SUIV2v7aaH9fotbJxKthERU/Z6ZhrY6ScAOfNNxJQeRi
	L5qcf0I+uwRjCvyopaOkBJ4Y4icxNfZPxXrODRSTu3dWhDR5dUdBB42i5Nt+rmoSywIn8PkAroa
	w4KTdt2LNgXycvdzGPcsRY6dgTHO/lUr3CHi826oomdauVFS4oAr+SHuSeSIbxKiCgZqEQhdQyI
	zkRWXTvCwIVr6T2mVJScuGEDuU11+vPSHjyCq92PTzCiKwCpEubg3e0qs1GrnKJriuGnYrUxnqY
	Ju6ilaskJ+dn6zO1aE24SKm2znDS2vZLtBuny8tf5qxFK1BMKhyfas7xmh7MRo0gwzIL9il/wWN
	m3GEx/JUMaSVOnuCEpbL8CTqYdnqZWyhMDSpTkTAWeNLeSIIsnUNrd40Ief9kHApCIPZxxOKdhm
	4tggH9YP+Rfr7cgiUuWxTh6gxBbW0U2Fu+pIjcwS8+rAkpbMz81kY33KGf3osiPfAfr2d2IaBjs
X-Received: by 2002:a17:90b:1a92:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39dbc6f0686mr1143950a91.23.1789174777016;
        Fri, 11 Sep 2026 17:59:37 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dbca4c9a5sm233719a91.0.2026.09.11.17.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:59:36 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	=?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykola Lysenko <nickolay.lysenko@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Tolerate libarena skeleton failures under BPF_STRICT_BUILD=0
Date: Sat, 12 Sep 2026 09:59:30 +0900
Message-ID: <20260912005930.2080724-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c2235ade283e0258e7ab018bafcc99b32a63f586.camel@gmail.com>
References: <c2235ade283e0258e7ab018bafcc99b32a63f586.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2026-09-11 at 13:24 -0700, Eduard Zingerman wrote:

> Why is this change necessary?
> The whole PERMISSIVE thing is quite ugly and I regret not being
> involved in it's review.

I hit it building selftests against the distro kernel's BTF rather than
one from the tree. On Ubuntu 6.17 that vmlinux.h has 5 __ksym
declarations against 269 from a tree-built kernel, and all six libarena
sources fail on undeclared bpf_preempt_disable, bpf_preempt_enable and
bpf_stream_vprintk. BPF_STRICT_BUILD=0 looked like the switch for that,
and the build still stopped at libarena while every other skeleton was
skipped.

The patch only makes the three libarena rules consistent with the other
skeleton rules. I don't have a strong opinion on PERMISSIVE itself, so if
it is going away or being reworked, please drop this rather than take it.

HyeongJun
