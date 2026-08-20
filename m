Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB63392C3D;
	Thu, 20 Aug 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250463; cv=none; b=U1HSWZQbE788Ay1LoPSuW38+6blxQdnkyVg7b+OetTKPf/NOiMzCt+EjRXEWwPiWbh74mQbSacYdyOPANooWu4I9mPLwL8Y00H6cM4a30Aa/AeD9QqXuvJxz2/do9oRRWKO0tRCZJ8EBJdyCImMVwQursN0XL423zveiwCq9jfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250463; c=relaxed/simple;
	bh=d/fJltRZl9r/iaBgDb9h/xUoBv4uX1us5Tyz7Hg7800=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JgA/dDuksC7/lu+io3Qg9fkG9J3D2gU0Ud7VUEek0go4uFzzbGNm/PQ2LO60QXJjUEFivNw4JLY9GSnj5LKEkpEDTM8gViYmHk/yLZaMGF02EC09ZNSwHMVipTfo60TFY9ZOFu5rMWJyeZo+I8NdAqfD97l9VMgug9KNh5ZhlJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMCauTM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMCauTM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DD71F00A3A;
	Thu, 20 Aug 2026 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787250461;
	bh=eFRlS8r57ngn2HiuYzDVdWJH91VR+R4WDw2yS3Zw3aY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NMCauTM03Ldyuxpwn0PEdSSjU29Awf30QUeHEBZgm+ucMx3R6U53KfQ79Kn7fm6jA
	 Cp7zKub/SZQ072TIlhmhe6uKZ4sl0/rsBfVQ3HZDMusDQ7kTuZ3YZQt3EH8FKl3Zw9
	 XPzraIyOjvcRkCZ2/D10RTvnr/+J2VJL+9KBCadM2iYhQZItGjt+WxTqRLv3yijsqv
	 DRmZQfxiiRiRwp/6gqBSnDJtI75rZj7UxcyOrlyJAbRYUmvhkGDFxBjFxacqdIYguU
	 z3ZN9JbzWGqDDyfNWphAm6ywsslnuSWWCXpjgH5vkrcHjdyXoXvFwX6GxM/z7yEdW2
	 tCyjg2IZWKu0g==
Content-Type: multipart/mixed; boundary="===============2759493290539329099=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fba2d36c24eebcbdc32ba8f1f117993b6a9a484e6bedefb34e02dfe2deb7464f@mail.kernel.org>
In-Reply-To: <20260819024443.781764-3-tushar.vyavahare@intel.com>
References: <20260819024443.781764-3-tushar.vyavahare@intel.com>
Subject: Re: [PATCH net-next v3 2/4] selftests/xsk: skip TX setup after RX configuration failure
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com,andrii@kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 18:27:41 +0000 (UTC)

--===============2759493290539329099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index bba5e8d4222d..814b8325493f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -1699,12 +1699,15 @@ void *worker_testapp_validate_rx(void *arg)
>  				       strerror(-err));
>  	}
>
> +	/* Publish setup failure before releasing the main thread from the barrier. */
> +	if (err)
> +		test->fail = true;
> +
>  	if (test->use_barrier)
>  		pthread_barrier_wait(&barr);
>
>  	/* We leave only now in case of error to avoid getting stuck in the barrier */
>  	if (err) {
> -		test->fail = true;
>  		pthread_exit(NULL);
>  	}

This isn't a bug, but the braces in this if statement are now unnecessary.
You've moved test->fail = true; out, leaving a single-statement block:

	if (err) {
		pthread_exit(NULL);
	}

Could this be collapsed to the brace-less form?

	if (err)
		pthread_exit(NULL);

The lines you added just above already use this style (if (err) \n \t \t
test->fail = true;), so the two forms are inconsistent within the same
window.

[ ... ]

This looks like a bug fix for an initialization ordering issue. Should this
include:

  Fixes: 90d52cd76f2f ("selftests/xsk: add UMEM users refcount and centralize socket teardown")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32400920730
--===============2759493290539329099==--
