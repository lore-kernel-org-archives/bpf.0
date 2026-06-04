Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29D284B3B;
	Thu,  4 Jun 2026 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537817; cv=none; b=OsgGRDVV0968B1mjDz/75SFN/kUYorSIu/vhoMenBYgsE6kj5Z0MZ7TuidJEkovVMWf6SdfsnVuYBxW/xA4QgokRQz1jBFazfxqfXkAYVxXuQI+QuMh4pMoyMi8rSlrKfNeYANfuVnnsEgktbU/qKZSonL4dq5uq896KX/sz45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537817; c=relaxed/simple;
	bh=fSHhPc1nkyayHXR4UTLV7h8T6og+5aZrAoJqvYS6yOM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DCxMG5QrIQdFrWk0aEd3bt+KB7e/H0HVCk7pSLOQkuPOoYfh2s5cbaKIPy8rk0qKmznwzMlRfanZcHEvH57r19s8z3ux7OICB2nNCiRk33FNxXqS4hK4UPSP5EnYIaWc1xevaEaJEtQUY8dPRyhKJegQzSA4tqU+d5XVxovrfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lALy0QtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lALy0QtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB421F00893;
	Thu,  4 Jun 2026 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780537815;
	bh=KUdq6UOSJnZpfKpTZ4ZN0nFQcjLimr2c1F9d/PXD35w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lALy0QtK2qLQhWc1C6QSpu7SLW/xGmMVhsQ8Q5zDFErmFCszuTV5lMFC8pmgxf/4D
	 iMkmxQQiLpFuvRmlp4wf/njNMgKSXZ147yZvUPm9mus/GfGnf7VL14EexpMkT+ziT9
	 aWBhjQ6SfU+rrjjrE+dH3n31+QtkUvK8YRbd1y7H8VvJLElMkZB59MHWvy86ms/gX7
	 JJHx1rvcISPgGDjTDUHtY035SCvUBaMNDpXX3htILKA3Fof85bmFtjoVkAsqRgon4Z
	 X4mFIQUfcbhgYt1o5i8pseG93lGVRu9qCp8GaiAoUoNu4YNwzTxEdHMh6jBrdCYjz7
	 QixkmmfHrZwfw==
Content-Type: multipart/mixed; boundary="===============9009006705736662526=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7b3e1adae5c92153e991ac406b2d334609c36d866b5bf81e4465cf63bde0a79c@mail.kernel.org>
In-Reply-To: <20260604005729.1992632-1-malin89@huawei.com>
References: <20260604005729.1992632-1-malin89@huawei.com>
Subject: Re: [PATCH v3 1/2] bpf: Tighten cgroup storage cookie checks for prog arrays
From: bot+bpf-ci@kernel.org
To: malin89@huawei.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: andrii@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,zhuyifei@google.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ameryhung@gmail.com,malin89@huawei.com,cuirongzhen@huawei.com,tanjingguo@huawei.com,cenxianlong@huawei.com,chenzhe@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 01:50:15 +0000 (UTC)

--===============9009006705736662526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a656a8572bdb..d85869544dc8 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2480,8 +2480,12 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>  				break;
>  			cookie = aux->cgroup_storage[i] ?
>  				 aux->cgroup_storage[i]->cookie : 0;
> -			ret = map->owner->storage_cookie[i] == cookie ||
> -			      !cookie;
> +			/*
> +			 * Tail calls keep using the caller cgroup storage
> +			 * context, so prog-array members must use the same
> +			 * storage cookie.
> +			 */
> +			ret = map->owner->storage_cookie[i] == cookie;
>  		}
>  		if (ret &&
>  		    map->owner->attach_func_proto != aux->attach_func_proto) {

Related to this patch series, Leon Hwang raised a concern about test
placement in the selftest file (tools/testing/selftests/bpf/prog_tests/
tailcalls.c). The new cgroup storage tail-call tests should be placed at
the tail of test_tailcalls() rather than before tailcall_failure and
tailcall_sleepable.

Reference: https://lore.kernel.org/bpf/20260603150213.68746-1-leon.hwang@linux.dev/

Leon's comment from v2: "These new ones should stay at the tail of
test_tailcalls()."

Should the test ordering be adjusted in the selftest file to address this
feedback?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26923843925
--===============9009006705736662526==--
