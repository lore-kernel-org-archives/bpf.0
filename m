Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF145450F2;
	Sun,  6 Sep 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707679; cv=none; b=DF3FLxPYwymkqPm/ncAyi7vGpaQCFOqNCgtoP2+MnXYdyrYQ1z0uqjPgNjHsrA27wafNIhC40oICZ/RDpO4inFD1trITgdwrZdK/mqr34Jwltsk6NRTOobsjg6DMExEzmcmJ54RxH0/U/g8EnnQFLydYsyl8a1gYo0QxuXdwxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707679; c=relaxed/simple;
	bh=+sB+WQJXysHrHhOucEe6Rlu/RPWRCZJhzNyPaoKWsBg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oBr4GJcVX/6UHwkQo3Ps6iCaRRO1/PYdLkPo5A7evMlxY+cvJF62eIijJ6sxtlzFFm1E5FU9d9K4rZc4RJN01TWMYF7CNi7U37vDmgZHlmp59q5h+beVS6ywkvMCrofDXFKJsEBBI3ln7XDjccAdpzDEq4cbvjbRafgJjVYN1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E97o2eNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E97o2eNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7EC1F00A3A;
	Sun,  6 Sep 2026 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788707677;
	bh=q49zIH3mpLcYNOGd8REqs9pJoERYniI/u/JBbg7FeVU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=E97o2eNiJAjY20GapxGnlMikHCrWEFNv2spfWLNnIBEZ8anExuWjbrLdVZtkD+NnK
	 Tt9ayC6k1lfR31+5sHGRUHzKj3FXSF3VpXiAaFKQl5wHc9QWybuyRoow4mlnCygnv0
	 bOchoBzGh0mUKgAso8aFsOsGXldBmNg0u/MBrFA2n3C9hMcTQITUn9gZPPRr/EFIFi
	 FiK/5kTNIeuf8jZ1AbyeJHLnYmdTnR/2Juu6wKvRhiBuX+BOpRAIAvCQtFENSR5/Rn
	 ZVtJfxNZWjDQjZd1nd3CJN5T9kIq66iE4z/3/pu947BasaW/Q1XE0a6l0ztPeq2nsF
	 1pDMHcPnPHOrg==
Content-Type: multipart/mixed; boundary="===============3615113983731378445=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1b61b90e780040376c607497d15cdeb9367bd49ad76635c7bbfac24531064a6@mail.kernel.org>
In-Reply-To: <20260906143918.848536-1-hi@tychen.cc>
References: <20260906143918.848536-1-hi@tychen.cc>
Subject: Re: [PATCH bpf] selftests/bpf: Check returned keys in map batch validators
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,andrii@kernel.org,eddyz87@gmail.com
Cc: hi@tychen.cc,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,yonghong.song@linux.dev,brianvv@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  6 Sep 2026 15:14:36 +0000 (UTC)

--===============3615113983731378445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
> index b595556315bc..76d3800a82af 100644
> --- a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
> @@ -45,6 +45,9 @@ static void map_batch_verify(int *visited, __u32 max_entries, int *keys,
>
>  	memset(visited, 0, max_entries * sizeof(*visited));
>  	for (i = 0; i < max_entries; i++) {
> +		CHECK(keys[i] < 0 || keys[i] >= max_entries, "key checking",
> +		      "error: i %d key %d out of range\n", i, keys[i]);
> +
>  		if (is_pcpu) {
>  			cpu_offset = i * nr_cpus;
>  			for (j = 0; j < nr_cpus; j++) {
> @@ -59,7 +62,7 @@ static void map_batch_verify(int *visited, __u32 max_entries, int *keys,
>  			      "error: i %d key %d value %lld\n", i, keys[i],
>  			      values[i]);
>  		}
> -		visited[i] = 1;
> +		visited[keys[i]] = 1;
>  	}
>  	for (i = 0; i < max_entries; i++) {
>  		CHECK(visited[i] != 1, "visited checking",
> diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
> index 5da493b94ae2..430949f9691d 100644
> --- a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
> @@ -50,6 +50,8 @@ static void map_batch_verify(int *visited, __u32 max_entries,
>
>  	memset(visited, 0, max_entries * sizeof(*visited));
>  	for (i = 0; i < max_entries; i++) {
> +		CHECK(keys[i] < 1 || keys[i] > max_entries, "key checking",
> +		      "error: i %d key %d out of range\n", i, keys[i]);
>
>  		if (is_pcpu) {
>  			for (j = 0; j < bpf_num_possible_cpus(); j++) {
> @@ -65,7 +67,7 @@ static void map_batch_verify(int *visited, __u32 max_entries,
>  			      ((int *)values)[i]);
>  		}
>
> -		visited[i] = 1;
> +		visited[keys[i] - 1] = 1;
>
>  	}
>  	for (i = 0; i < max_entries; i++) {

This isn't a bug, but map_tests/ has three near-identical batch
validators, and lpm_trie_map_batch_ops.c still has the same
position-indexed visited[i] = 1 marking that this patch replaces in the
array and htab copies. The changelog scopes itself to 'the hash and
array batch validators', and the LPM key is a struct so it cannot index
visited directly, but would it be worth covering the third validator in
the same series (perhaps keyed off the parsed last octet), or is the
struct key a reason to leave it alone?

The first half of the changelog states the problem and the fix clearly.

> The hash and array batch validators mark visited entries by output
> position, making the subsequent completeness checks always succeed.
> Duplicate keys with matching values can therefore hide missing entries.
>
> Check that returned keys fall within the populated range and index
> the visited array by key. This detects missing entries while preserving
> unordered results and existing per-CPU value validation.
>
> Controlled inputs confirm that the old validators accept duplicates
> and out-of-range keys with matching values, while the updated checks
> reject them. Ordered, reversed and shuffled valid keys still pass,
> and scalar and per-CPU value corruption is still rejected. The full
> test_maps suite passes with no skips on the matching kernel.

This isn't a bug, but the last five lines describe an ad hoc validation
harness that is not part of the patch and cannot be reproduced from it.
Would this validation narrative read better below the --- line, leaving
the changelog to the problem and the fix?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34040182269
--===============3615113983731378445==--
