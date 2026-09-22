Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097F340400
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046105; cv=none; b=lJsLJC01HGZFcqiGgxBipYT/N+dm3U1Q/cKYX+EYF+eYWeWrZ94AbbR3euYK3O32+xvdeDYSupsIeOjxDdsS7bEktyt3BB5y/G37HuXlHgwFN8ZNIaszGW+poAAmBmDs31MCdpi5DQ8/nMUbLGv0lyP+RL6E9TZcwqmsCQjdC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046105; c=relaxed/simple;
	bh=66nZ/1XFHol/Rw8BE0RJafNsIZMfRKBZ31vv5YZKJck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YNI2akDf1rIuC64o0jqwxqHOkqVCt0BMF9BVS7Dn6WtsGts7GQwJhvVe9jCHNz5g4DOeYnsdILcZNKXHl4ciq8pYulgBw7l6Jas31kvfy0zlnZs9AoZUs6V4ko+pwLRCtHlCtUfUcoILH36o6XLRZvXuDZKlRLtzZ2GKUVIEmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZvEEDkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZvEEDkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F7F1F000FF;
	Tue, 22 Sep 2026 03:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046104;
	bh=TgaTRvAGszXEM1fyp9Eq7637Sx2tHbLXThmSX77gDB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZvEEDkhEiGVbzuw9C2kXjGX+MJKyA05xa+21mGwTb1HikmDAEeBUa4D6gFPbevAA
	 z5pE3qSRQylkHax/HIbq+EH/wKHFs9KMSo4Rliw//cyn8ehZXvwWwggNjNQMjbz9Rk
	 +xvoZN9NEy7S4yNZrWHVgxzo5ys1IIWNGa85a01MvP8n38V9VtpYT7Sk4pRnFsvNo4
	 n8syy7d1THLTC52t5FOTm+xxYfqs5D1mz+sJlaT/uDOULn6uxIH+X4el1Ewq0ZOvn5
	 BAT1qVid3uGO4mImHEwHzWOROHfqaJSSlmLTW4M5FsYVfSRBPEked0GbLBne1iCZC7
	 k3LCP3Wu/N0nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Add support for BPF_F_PREORDER
 cgroup attach flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922025442.3176057-4-sh_def@163.com>
References: <20260922025442.3176057-1-sh_def@163.com>
 <20260922025442.3176057-4-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 03:01:43 +0000
Message-Id: <20260922030143.E4F7F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bpftool JSON ABI breakage for attach_flags field
--

commit 7ba7f84eaca8177e2045dffce655aae4da559465
Author: Hui Su <sh_def@163.com>

bpftool: Add support for BPF_F_PREORDER cgroup attach flag

This commit adds support for the BPF_F_PREORDER cgroup attach flag to
bpftool. It updates attach operations to accept the new flag and modifies
the show operations to output combinations of attach flags, rather than
just a single flag.

> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index ce69d1e5468e3..fee1a260f6d1a 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c

[ ... ]

> +static void show_attach_flags_json(__u32 flags)
> +{
> +	char buf[32];
> +	size_t i;
> +
> +	jsonw_name(json_wtr, "attach_flags");
> +	jsonw_start_array(json_wtr);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(attach_flag_names); i++) {
> +		if (!(flags & attach_flag_names[i].flag))
> +			continue;
> +
> +		jsonw_string(json_wtr, attach_flag_names[i].name);
> +		flags &=3D ~attach_flag_names[i].flag;
> +	}
> +
> +	if (flags) {
> +		snprintf(buf, sizeof(buf), "unknown(%x)", flags);
> +		jsonw_string(json_wtr, buf);
> +	}
> +
> +	jsonw_end_array(json_wtr);
> +}

[ ... ]

> @@ -182,7 +240,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type=
 attach_type,
>  		else
>  			jsonw_uint_field(json_wtr, "attach_type", attach_type);
>  		if (!(query_flags & BPF_F_QUERY_EFFECTIVE))
> -			jsonw_string_field(json_wtr, "attach_flags", attach_flags_str);
> +			show_attach_flags_json(attach_flags);

[Severity: Medium]
Does this change break bpftool's JSON ABI by changing the attach_flags
field from a string to an array?

Previously, this field was output as a single string. Changing the data type
to an array could cause external scripts or applications using strict JSON
parsers to crash or fail to unmarshal the output when running=20
bpftool cgroup show -j.

Would it be safer to format the multiple flags as a single comma-separated
string in the JSON output, similar to what is done for the plain-text outpu=
t,
to maintain backwards compatibility?

>  		jsonw_string_field(json_wtr, "name", prog_name);
>  		if (attach_btf_name)
>  			jsonw_string_field(json_wtr, "attach_btf_name", attach_btf_name);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922025442.3176=
057-1-sh_def@163.com?part=3D3
