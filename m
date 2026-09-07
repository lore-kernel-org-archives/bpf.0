Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6AB3E51F4;
	Mon,  7 Sep 2026 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747684; cv=none; b=eh4IwQMVhCVklmvwzEBiZY+PZmioL5BolTVlYTaZ0LR+XFELlWtzv64PLVI8+ggDOwELNSxAm6cowpK3yEasSHVt3rpzHGr0ZFEZzBGVXlsOhNaKOVsHG+XnblJFPn6iNNAMeAbf0Jz7/RUIak8aUFQEP1/aZP+k6SW0xYB281Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747684; c=relaxed/simple;
	bh=S+wH4OQGwTZqdlw5p8iFiWsWTOAHxiRvrbCeRb1aMEQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mdnyDDtWr4E/XyFmznyY/dSzckMLhgKX0ybdFEmtLrgy2DnrS2kaajCLa9Q3IDPfc6AGrrd1BBtwvUHSIWmXCFaB8xd2POD6fsaTjQYd5Da9z/ZzJ4zAL/0KUbs7hWtbSRq/v7GJU6/K3hGFXPiVxhQ1a3rQkTYSo0NpjVwX2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwTGjTr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwTGjTr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB531F00A3D;
	Mon,  7 Sep 2026 02:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747682;
	bh=NAwIRBJBYwYtGCevL80Y84ihHAKeB62K/z2mZkfMW4A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FwTGjTr1UUeYOKr3pdg65acSY3JoJAuOQLF3jimF0rW2cHTv6h4EAmxQSuFkETbV5
	 7KOjdJ8dvqH2Ae8tEAz1hwEUzO77YNbyzqsA14MMnW9sBkHyexLzJvMAgTLC/7x+x/
	 29sMDUO3KIA57FAQR97SuU/bgDRrvNo2+cI1m9n8F/0HJzo2qjdu2NSCgBRM1DgFz+
	 JaU8XiqjY28hDQ3bBxfWvGoXfSyGYGiX0OvhjlQNZlwO/+yDkORO/tMiWOQxNt6vjB
	 hFBFqTzKSTm1214Ge6fG5RtiS1EP2JhuI/WGvsO0/Z1x2zLLk7BA8Ab7LA6XoxLXG9
	 kBTQ0QDyv1bhw==
Content-Type: multipart/mixed; boundary="===============5442262632503210716=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0782d0099757c7e1db80424baf0e58fe5983cb08850a95a4df0bcc564edd7f6@mail.kernel.org>
In-Reply-To: <178874362960.1415955.17339804697296063298.recursive-v3-1@tychen.cc>
References: <178874362960.1415955.17339804697296063298.recursive-v3-1@tychen.cc>
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Add recursive map dumping
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 02:21:22 +0000 (UTC)

--===============5442262632503210716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 29ab48522e4514042981557a125a6b9d94bd4e9c
> Author: Tianyi Chen <hi@tychen.cc>
> Date:   Mon Sep 7 09:21:26 2026 +0800
>
>     bpftool: Add recursive map dumping
>
>     Dumping a map-of-maps currently shows inner map IDs without their
>     contents. Add -r/--recursive to dump referenced inner maps as well,
>     leaving the default output unchanged.
>
>     Show the selected maps followed by discovered inner maps, with each
>     map's header and entries. JSON uses an array of these map objects.
>     Preserve BTF formatting in plain output, including when typed and
>     untyped maps are encountered in the same traversal.
>
>     Keep selected map FDs open and queue distinct inner map IDs. Open,
>     dump and close each queued map in turn, requiring only one additional
>     map FD regardless of the number of inner maps. Preserve per-entry
>     lookup error reporting for maps that do not support element lookups.
>
>     Report failure if an inner map cannot be opened and close any JSON
>     containers before returning. Document deferred ID resolution and the
>     non-atomic dump behavior, and add option completion.

This isn't a bug, but could the changelog spend a little less space
restating the hunks and a little more on why the queue-then-reopen
approach was picked over keeping every inner-map FD open? The first
paragraph states the problem and fix well, but the following paragraphs
walk through the diff hunk by hunk, and the final sentence enumerates the
documentation and bash-completion changes themselves. The one piece of
rationale a reviewer would want - why a single reused inner-map FD was
chosen over holding every discovered FD open - is stated as a fact
("requiring only one additional map FD") rather than motivated.

[ ... ]

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb72414..c400b15f16dd 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> @@ -919,9 +980,34 @@ static int do_dump(int argc, char **argv)
>  	if (nb_fds < 1)
>  		goto exit_free;
>
> +	if (recursive_dump) {
> +		ctx.seen = hashmap__new(hash_fn_for_key_as_id,
> +					equal_fn_for_key_as_id, NULL);
> +		if (IS_ERR(ctx.seen)) {
> +			ctx.seen = NULL;
> +			p_err("failed to create hashmap for recursive dump");
> +			goto exit_close;
> +		}
> +		/* Record the selected maps before discovering any inner maps. */
> +		for (i = 0; i < nb_fds; i++) {
> +			len = sizeof(info);
> +			if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
> +				p_err("can't get map info: %s", strerror(errno));
> +				err = -1;
> +				goto exit_close;
> +			}
> +			err = hashmap__add(ctx.seen, info.id, 0);
> +			if (err) {
> +				p_err("failed to record map id %u: %s", info.id,
> +				      strerror(-err));
> +				goto exit_close;
> +			}
> +		}
> +	}
                   ^^^^

A subsystem pattern flags this as potentially concerning: the pre-pass
assigns the raw negative errno returned by hashmap__add() to err and then
propagates it out of do_dump() as the command return value. Every other
error path in do_dump() and map.c sets err = -1, and the new
collect_inner_map() helper deliberately normalizes the identical
hashmap__add() failure to -1.

A -ENOMEM here would make 'bpftool map dump -r' exit with status 244
instead of the 255 used everywhere else in the file. The -EEXIST case is
unreachable (map_parse_fds() yields maps with distinct ids), so this is
OOM-only and both statuses are non-zero - but it is an inconsistency
introduced by this patch and trivially fixed by 'err = -1;' as in the
sibling helper.

> @@ -936,7 +1022,7 @@ static int do_dump(int argc, char **argv)
>  		}
>  	}
>
> -	if (wtr && nb_fds > 1)
> +	if (wtr && (nb_fds > 1 || recursive_dump))
>  		jsonw_start_array(wtr);	/* root array */
>  	for (i = 0; i < nb_fds; i++) {
>  		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {

This isn't a bug, but in recursive mode the pre-pass and the dump loop
each call bpf_map_get_info_by_fd() on the same fds. Could the pre-pass
hand the ids it already collected to the dump loop instead of querying
every selected map twice? The pre-pass genuinely has to run before any
dumping so that a root map that is also someone's inner map is
de-duplicated, but the info it already fetched could be reused (e.g. by
recording the ids into an array alongside the hashmap) instead of being
re-queried.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34073252721
--===============5442262632503210716==--
