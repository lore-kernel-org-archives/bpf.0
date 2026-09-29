Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C13438B9;
	Tue, 29 Sep 2026 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790723497; cv=none; b=d1Jh+//E2yyZMksTT/9ye+el9DsXRNR1gT9Zufv4F0LQQAhF0n5r/bkEg5cw8iaf98YFvjtELdCrzqT/8RFnBX6OBYtbY7rSDCQjBvoxtIxnHbBxOBFvrJPGcOcfy9JBDwYA/GBzBiyJb5k4VS5SRMQypRzkmMkLF/rjRwa+noA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790723497; c=relaxed/simple;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cJZLb2jlyV/DpIEvi+bscwzqMZ77fMZYNGY7X7kHycFTFkUj+1sGS0ZTk7qoGnNiwtLAE9MVjny/LK/nGueimwACHzi+i28aJDc8ld+iyij+fVLoN5g3FxI933CQwvu9SBkcC2HCEFsm/u1YjQx62QzT45Qu6jA46xeA60gKaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRCzRGvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRCzRGvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FE91F000FF;
	Tue, 29 Sep 2026 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790723496;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mRCzRGvZIYg7IzyFLgXBfBrkHUoluWTIYWcOtLej3wDtaIMUQLkJ4aKz3cvCms0qd
	 A4UTsf212JZRi0/itEZCDuhHIXZaFqnMscQUY24TloncaXPu8sKLF5cpF0KoBAzzFX
	 WnTbrHEPLnZF01t69Q4yALfqP34V/Z5ibDHQDDu5IpCnXtMuoTyVUA5SGCFCjTFtJe
	 7LddOt6t5BJIWfhg5gtahaLHljD5BQDRm+yg+ZUj0jBIz03nKkH69Fm8uX7XHOVYTs
	 57mv1eqHeVbSQi57Dw2I4/xE0Tpfa5gx4VFB6XYjgJRzskm3jAjUkCGjkUu2v54Eui
	 d/aCi/oyOVfgw==
Date: Tue, 29 Sep 2026 13:11:35 -1000
Message-ID: <c0b95acfee4d3becce0718035c45e4dd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Work around pahole 1.32
 dropping scx_bpf_task_set_lazy_resched() from BTF
In-Reply-To: <7c139810be5ffc9764ed4236efc28794@kernel.org>
References: <7c139810be5ffc9764ed4236efc28794@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
