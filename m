Received: from mail-qv2-f0.google.com (mail-qv2-f0.google.com [74.125.230.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBF43F8D9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266562; cv=pass; b=shg+qvo7KLHu/vNK/lwX4N/QtMQOL4ZGfm+QKnvKMOq7cQGvxC9d8Flbj80B+FQEm+x/m4RStmW/YWRuEiT9CnhF3ifkvMQW7em0V6HlE6NkLMIpbLONYR+AFgRJssturfXHI9INReziYvO5JMt0WtlUA6bCDRwU6IuED08HtQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266562; c=relaxed/simple;
	bh=AzxhmYlqJMtI2hGV/3afybSd85lTojyYwdmA+SxmSSU=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F64V5GlD+2iFHkNIZ5VGw+iRFxQCFTzSKeA7ZZoVNoeRZsOyMnUH5Aw2xaG2lM0LU80nPwPa8QvkJ8arIbIRSsUFcogXehsBIl6HGdvDcIhZiru+l+3JOF9ciYfomAgptKt/jwd6C7dWJSc3ptVBQaqU34L++jEyxWmP8yl7PE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw+2tO42; arc=pass smtp.client-ip=74.125.230.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw+2tO42"
Received: by mail-qv2-f0.google.com with SMTP id 6a1803df08f44-910603aa531so103986d6.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790266559; cv=none;
        d=google.com; s=arc-20260327;
        b=oSKR11nok6DNDP5zsNqn/hROuhluKBcVwxZYLSWg+ZZ+RiCkSRjTcWgPBaeMGrn9FN
         YROvn81YX8mlyFNBlI0eYSlOuQGlIRQRa6HZor4Y3sv3xGzC3cTI4GWH5VEoJtmJCsMM
         1nulh0AMGMmcvCzeeQOLZl/RHCEEmY3zWUc3QZxCKNvmPInWf8eWP4toGde9aUynoq78
         LcK2A7tTDCWCwuECDWxfVK5O+Dbl7wXvZpoKeSA6AXirqxxsEx2Bg0WsZjDYLzVokpLh
         5myjSxch0jAXDhLV52kww7Op1FLpitxccJL9MBpk6aSKyX8eQGNN5am3esZZlQdE6C0W
         CsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=8VzKkG9mi98ONJzS+sXNaXBzrMP/Vmv7pjoyvpH11DA=;
        fh=ZqsbCIb2GN2KOl/EevUDRPKfC3NR8S9fwNdVhf7l2EE=;
        b=oGEoxWkRmLn33WqkpEhxR9+KdcjjP+u01lGuKcTtMKZC3UClGnT+uHqN7dHnJzqmI0
         XnsmAguyAWOf8AtKjc79UxrkZJ6GO9/5OXRC22T4rODN56L3cIYNZMwMSLwgrq47iNOR
         vb6nDrjVy1A566LV2Qje9TAjB8IgHVDHh3UG2vEqnjNN06ijfPqITL2MFs5IbhzKz/np
         fqDY3oMYBXwMMiN1eABJM47BvUW2HQlQFG5FP2YxUCYsP9ic/RhPVILuvSrDMjaTq0Cr
         6UHJbfuxf381BE6mIBUqOUgsvx1DNH9SndNlJ+l8rpfLY4784HnwVW4Y0XIlhlK2XkCz
         EQcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266559; x=1790871359; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8VzKkG9mi98ONJzS+sXNaXBzrMP/Vmv7pjoyvpH11DA=;
        b=Lw+2tO424QQg74GQzpY6feq33s82iMeyR8SLSHhYPTNvayhXYkcgxAEsVZFwVeTesa
         fHnmzWmlSpUPDN56sRA5HUKds1WfbWG95txBn4oW4tijOo+W2FZNpnBBuzYUD/kPCSG3
         xuaCcs6MazDMbM4N/ZZtcIT9M3mQiQVNju4lCBdpgo+crzvoO+UOAL5OjTyvkv0jxaA8
         mLq89NNXrwtLxAbWlvNyTI1+IHtYGL3PH3PAEIoXZXyt895C7pOQYt+RMNvhjGjNn3Fy
         rHIbw69+9zjeIVDOUOiq62pkcAnr2Iy5eF0928IJWzVNwRF6unZ3zHqZ5nAzlR+0yS4G
         ML1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266559; x=1790871359;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8VzKkG9mi98ONJzS+sXNaXBzrMP/Vmv7pjoyvpH11DA=;
        b=Yewiqe9EG45bzdi2uuSovU+ehjUFOSQhJsrshBn636UpZp0qrl16GaSHT9LT3iIxFY
         Q5a9BFgE6DdJbGNzpMXoTdzXbxIe8c+6LeYrtFT67VOkfpx3IMUYAkzWzOypWg9duADt
         ZyO6xXFzuxG34mjynbz3/t85O3UXKvUP9t+AdWy49H4aWt8zmCxmeJsWVoMxEofyY6Ah
         0GWy9D4R3gpZzlhiaJG5YvnCzuK+34Pm3TOOO7jORgTJKEO9RprNQMGxvZcIZ4wyCl3N
         HctC5BZ7wVWgyP/oRUuvcQMia4HOEoPnsAjbpI4NFOLjSydZ3RNpr85MBiMzlp/hMhXm
         XsdA==
X-Forwarded-Encrypted: i=1; AKwUvBySsA+/2pk98RcONTogjsJLhmq/xUY5pkf2wIVFr2tvwEY0qUNoxS8ZYELRhdMF2nILBis=@vger.kernel.org
X-Gm-Message-State: AFuF++lXLAb842w/VJGd0RJKdkr166lbGaKLPRQzMtR0YUCTUrswHkES
	trIQcdMOnLEKBZ8Mj73S5kr9k649QOjyB9no3rP+bR2SW1LVZDFn6zuH+kj1dFICHTeleQlYtqd
	OVVke0tq6jXAJj96GIKpCQXyiFKCHO5I=
X-Gm-Gg: AYBFou1khqi7PkUa/bzPRxCU06Q/96EMvkYxWxI0F2AwvAWnzDhgl5wAB9aOxJ9J4uh
	wcXNA8huLgUMDEhqcfej2zKdwef+iwUnntwQVEYi5GYvrCkvhncGy4w1ESUPw1cKUGvclaeYnrx
	jdSBk7bctfjKsCJLCvH/gt5In/Y1XvTfZg/41VmZf+cG4fM6e5G36Ca6WdVy3GEyRSFA8cpTmx+
	NHSlIgGhOwSYTneBRVL9y0JYt/pDKDnYLJY2Xnsyby4nZxqfyR9RtqX+d/j4jYZLDcmoO75gJIW
	eB/gn/CAWAwdTGnZekmsnkhpyf3tVomfN/mY9DPyLPOoUtHOx3QiIg==
X-Received: by 2002:a05:6214:f0f:b0:913:fa79:99c3 with SMTP id
 6a1803df08f44-91421f13ba5mr28893306d6.43.1790266558827; Thu, 24 Sep 2026
 09:15:58 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 09:15:57 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 09:15:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tianyi Chen <diannaaav@gmail.com>
In-Reply-To: <44ec5184-5a77-413d-9f42-fd93b0abbf11@kernel.org>
References: <20260911051053.283421-1-diannaaav@gmail.com> <20260911051053.283421-2-diannaaav@gmail.com>
 <44ec5184-5a77-413d-9f42-fd93b0abbf11@kernel.org>
Date: Thu, 24 Sep 2026 09:15:57 -0700
X-Gm-Features: AclHuK9YCtTvd_QbdRbtmViunIHXj9l7XzS8j0CSByJO8XmDbA6NWq1LazlJuiE
Message-ID: <CACGbirS7z-ND6bBhdd2RMyGhj5kwHi+Nng23Z=qG4+W3uaxd2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpftool: Add recursive map dumping
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

> break the line after |COMMON_OPTIONS|

Done.

> I'm not sure we need such a detailed description of the output format

Removed the detailed output/error descriptions and JSON-container note.
The man page now describes recursion and the non-atomic traversal.

> bpftool map dump id 1337 recursive

Changed to this keyword syntax, with per-invocation state and matching
help, completion and selftests. The global -r/--recursive options are gone.

Sent v7 as a new thread:
https://lore.kernel.org/r/20260924161434.95116-1-hi@tychen.cc

All 13 map-dump subtests pass. I also checked pinned maps, per-CPU inner
maps and keyword scope across batch commands after rebasing onto current
bpf-next.

Thanks,
Tianyi


On Thu, 24 Sep 2026 16:59:35 +0100, Quentin Monnet <qmo@kernel.org> wrote:
> 2026-09-11 13:10 UTC+0800 ~ Tianyi Chen <diannaaav@gmail.com>
> > From: Tianyi Chen <hi@tychen.cc>
> >
> > Dumping a map-of-maps currently shows inner map IDs without their
> > contents. Add -r/--recursive to dump referenced inner maps as well,
> > leaving the default output unchanged. Show the selected maps followed
> > by distinct discovered inner maps, preserving plain and BTF formatting
> > and using an array of map objects for JSON output.
> >
> > Holding every discovered inner-map FD open would make descriptor use
> > grow with the number of maps and could exhaust RLIMIT_NOFILE. Keep the
> > selected map FDs open, queue distinct inner map IDs, and open, dump and
> > close each queued map in turn. This needs only one additional map FD.
> > The tradeoff is deferred ID resolution: concurrently removed inner
> > maps can disappear before they are opened, so the dump is not atomic.
> >
> > Report failure when an inner map cannot be opened, retain per-entry
> > lookup errors, and close JSON containers before returning.
> >
> > Link: https://github.com/libbpf/bpftool/issues/58
> > Assisted-by: LLM
> > Signed-off-by: Tianyi Chen <hi@tychen.cc>
>
> Hi, and thanks for working on this!
>
> Please find some comments below.
>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-map.rst |  22 ++-
> >  tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
> >  tools/bpf/bpftool/main.c                      |   7 +-
> >  tools/bpf/bpftool/main.h                      |   1 +
> >  tools/bpf/bpftool/map.c                       | 130 ++++++++++++++++--
> >  5 files changed, 151 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > index 5daf3de5c74..23faa672685 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > @@ -16,7 +16,8 @@ SYNOPSIS
> >
> >  **bpftool** [*OPTIONS*] **map** *COMMAND*
> >
> > -*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
> > +*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } |
> > +{ **-n** | **--nomount** } | { **-r** | **--recursive** } }
>
> Nitpick: I'd rather break the line after |COMMON_OPTIONS|, like in
> bpftool-prog.rst.
>
> >
> >  *COMMANDS* :=
> >  { **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
> > @@ -170,6 +171,25 @@ OPTIONS
> >      Do not automatically attempt to mount any virtual file system (such as
> >      tracefs or BPF virtual file system) when necessary.
> >
> > +-r, --recursive
> > +    Also dump the inner maps referenced by **array_of_maps** and **hash_of_maps**
> > +    entries when running **map dump**. Each map ID is visited once, even if
> > +    several entries refer to it. Selected maps are followed by their inner maps.
>
> OK
>
> > +
> > +    Plain output includes a header identifying each map. On success, JSON output
> > +    is always an array of map objects, each containing an **id** and an
> > +    **elements** array, including when only one map is dumped. Outer map entries
> > +    retain their **inner_map_id** field, which identifies the corresponding inner
> > +    map object.
>
> I'm not sure we need such a detailed description of the output format in
> the man page. Please remove.
>
> > +
> > +    Inner map IDs are resolved when the maps are visited. The dump is not an
> > +    atomic snapshot: concurrent updates can change map contents or remove a
> > +    referenced inner map before it is visited. Failure to open a referenced
> > +    inner map stops the dump and returns a nonzero exit status. Output may
> > +    contain maps or entries printed before the error.
>
> Same thing, I'm not sure this is necessary. Maybe just keep the first
> half (the note about the maps susceptible to change during the dump).
>
> > +
> > +    In JSON mode, the enclosing arrays and objects are closed before returning.
>
> Let's get rid of this, please.
>
> > +
> >  EXAMPLES
> >  ========
> >  **# bpftool map show**
> > diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> > index 75cbcb512eb..45c336d63be 100644
> > --- a/tools/bpf/bpftool/bash-completion/bpftool
> > +++ b/tools/bpf/bpftool/bash-completion/bpftool
> > @@ -261,7 +261,7 @@ _bpftool()
> >
> >      # Deal with options
> >      if [[ ${words[cword]} == -* ]]; then
> > -        local c='--version --json --pretty --bpffs --mapcompat --debug \
> > +        local c='--version --json --pretty --recursive --bpffs --mapcompat --debug \
> >              --use-loader --base-btf --sign -i -k'
> >          COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
> >          return 0
> > diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> > index 5ababd8f7d0..c0f4df10102 100644
> > --- a/tools/bpf/bpftool/main.c
> > +++ b/tools/bpf/bpftool/main.c
> > @@ -26,6 +26,7 @@ static int (*last_do_help)(int argc, char **argv);
> >  json_writer_t *json_wtr;
> >  bool pretty_output;
> >  bool json_output;
> > +bool recursive_dump;
> >  bool show_pinned;
> >  bool block_mount;
> >  bool verifier_logs;
> > @@ -456,6 +457,7 @@ int main(int argc, char **argv)
> >  		{ "json",	no_argument,	NULL,	'j' },
> >  		{ "help",	no_argument,	NULL,	'h' },
> >  		{ "pretty",	no_argument,	NULL,	'p' },
> > +		{ "recursive",	no_argument,	NULL,	'r' },
>
> The "recursive" option that you add is specific to a single subcommand
> for "bpftool map". It's true that some other options behave in a similar
> way, but overall, bpftool tends to use dash-options when it affects the
> generic behaviour (perfect example: JSON flags), and keywords otherwise.
> In the current case, given that we don't really have an equivalent use
> for "recursive" for the other commands, I'd keep it a keyword:
>
>     bpftool map dump id 1337 recursive
>
> Could you change it, please?
>
> The code itself looks good to me, thanks for working on this!
>
> Quentin
