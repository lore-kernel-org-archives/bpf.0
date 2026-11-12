Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504877;
	b=3gyhTGpGQCR8hXnLh36RDmD70WIKGIP0DAmKJtl2y530KZSkk/R7gZogta3DC/K87dF/
	 d7S3KySRdyzfoGpmvRsU0+UPjDTmENeuRIyA9E96CdCZbwe7ElkQRak4A3n9JnfJ5txvT
	 vWnXDJbQygDUwnwv4jJTIu5o7mmpP7scPwvcez3zJuhROonRNWzIulmTK9xO4c6tyGxrJ
	 iSCgJSzv4r07ddALODGI/vueBHnHcSs9wtouVppoGoZEqm/w7fIMVNZO1RFLYUZdRaBjs
	 Gga7SU5GeX5clpuQRvw6x04MqEp8mOeNA38Y16NZ1LoY6ft7C5bGL8Mbe5ZAxcHMZ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504877;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TA008hAqewTJD4hEo+osy0YaIWQxYDyL3JeeJMKdpIs=;
	b=45WLWd2WRrPPx3Cx4jhAhZczFI8Skvaa2v7dhhiNX0YJIW6oJNTscIIhrNJM5pvYsANw
	 VWCcBuoq63JXoW3dmOSW1YR9sV8UkmfbNh+quwM5CyucF6yR6QRQ8Z7FIkmS1Xie7kPIv
	 x1FC0MO+50kpMSfPNlFu5/4y75I+4ubWj3LIkJNgpvwH5/UFuSsqqD9V1l8xeJJPmpQ3b
	 goRkd3eWkIzCwj9ci+PH7mJ2mHKP1UjIAs/GKrz2RKohNLetMdt3+2sQdcsUgeX5rXJOZ
	 CXh/qtlHrC84QvTptoSbxoIX1l3Zvar56Klfnf+TKrfoN0CzhtjexR+4w4mFS9u/KzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZG2UfvUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1A2606E95D;
	Thu, 12 Nov 2026 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZG2UfvUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05A81F000C4;
	Thu, 12 Nov 2026 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504877;
	bh=TA008hAqewTJD4hEo+osy0YaIWQxYDyL3JeeJMKdpIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZG2UfvUAfNvoouQAm17d7DCOmJPGpqdeb6gGZqx2R2NlgDJB/hiIdGHpdpzLwAsH5
	 epqHz/opgpe61GQt9Fr7RLx9McIyBO2U+zJUfDehqrl34NVBHRPT1iRgUqPq2vyahW
	 8x1C7Pd1tn8rdZxapxhU/YRjqIfeqGqWzPoNpnSTVHEW1svEpn3wDDtLx7SQtPyHZA
	 8dN6nbJzdXjK4SAjZou22Hh0ZYgPJmy2tk7VUBY8ERUBs03FZmafleaLxi75L6qp4Q
	 lXlp7cXsXdNikc2N7LDK97w5Tk4Ctjj1yLawkCh/ND/3CV6fTQ88RvrRbROruJ8vzu
	 qtVFtpyyBRR8w==
Date: Thu, 12 Nov 2026 07:34:36 -1000
Message-ID: <750f8463dfe748b33d7c76f6d2ddbdb7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, liwanwu@kylinos.cn, usama.arif@linux.dev, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 4/6] sched_ext: Reject cid_online/cid_offline on sub-schedulers
In-Reply-To: <20261112130934.563321-5-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev> <20261112130934.563321-5-cui.tao@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Tao.

On Thu, Nov 12, 2026 at 09:09:32PM +0800, Tao Cui wrote:
> Reject the declaration at load time like the cpu-form sub_attach/
> sub_detach rejection next to it, and note the root-only delivery in the
> ops kerneldoc.

A scheduler can be both root and sub depending on how it's loaded. I don't
think it'd be necessary to require them to use a separate op table depending
on how it's loaded.

Thanks.

--
tejun
