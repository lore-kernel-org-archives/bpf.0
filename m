Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8513D669A;
	Mon, 31 Aug 2026 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168858; cv=none; b=I+8v07PvMgZxucBRf/GvE4sCeH4v7tYY+W5JA4h+kPhTn0AsTdK6Bxv/A4J+MJ3fOTZtU4vb9UPBi9xOtjEgivwM8iZ5+6/JwOKup4XAaZ68pg7iKZxzc88qNQHE7Ff8ac44sKW0EV5Pg8pUEclImYu/qvviIXP4f/z0yVwnefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168858; c=relaxed/simple;
	bh=1tj0NoqGV5HEMFPSJmWsLwtMbrZ33YoUE6i+6+Dv1tw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eWifbG3/S68pvD7pa5Ve9KwCF7Vmj/t0aqofOpMBppXFfyYGKyciCnDIV5/AZNo06qJy6DqhF0DjXzwSXMOWeG8FSZ3vpqsnOih9ZHestmUEVKdKLdRh5BSmsgzJqI313st/9vTgsTsZDI0TlKbiWHB5ZbyTwCipX81ayATy848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+eowvLw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+eowvLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17981F000E9;
	Mon, 31 Aug 2026 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168857;
	bh=Mgd3jYo71B9FtLBTk9OpqzYveBhS1MAY5oLuskie0r8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+eowvLwsICuoqO1y7shLFFqnPn8RBLFsWmWW3VIsx5ckESHKfnwhQ6ecmN9oDoxD
	 Vz/IEf4b1faGn8+bFi8pFTt34KSOezlwoIj62CR0bjFKVHVQht3sx8NaKLr+8Amm82
	 WhteHBxzyu8rdXPH4vfupr8N6rge5exlj1RZncWGRm9F02cnO7Ot4sU3Nqr8TO+QBS
	 pG2q/crzMeqLlFN1dcHgragmARgUfmKWmRnF0bjUHuihc5TrQ/I8CMOrIc6h0aVtHi
	 t9YixEeA9On/GYWSoQDAUmKb7FS2/QqpSDMgQUrlJ083HxTef2/fK2xIRlFtJNSe0r
	 +TrcYIvS4EZAA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/20] tools/rv: Implement BPF monitor loading and
 tracing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260831090524.106845-14-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-14-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:34:16 +0000
Message-Id: <20260831093416.E17981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] A failure to reset one BPF map aborts the reset process for all =
subsequent maps.
- [Medium] Memory and file descriptor leak when `bpf_object__load` fails.
- [Medium] Reused BPF links are not unpinned during cleanup, leaving their =
BPF programs permanently attached to the kernel.
- [Low] Calling `get_state_name` twice in the same printf argument list cau=
ses both fields to print the same value if BTF lookup fails.
- [Low] `extract_enum_names` fails to strip the monitor name suffix if the =
monitor name contains an underscore.
- [Low] Missing bounds check on `data_sz` in `handle_event` can lead to out=
-of-bounds memory reads.
--

commit 18d2a63fa7007876f35f76e7406322321e0a0eb2
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Implement BPF monitor loading and tracing

Implement BPF monitor loading, execution, and optional tracing
functionality.

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification=
/rv/src/bpf_monitor.c
> new file mode 100644
> index 0000000000000..e13ae35678cb8
> --- /dev/null
> +++ b/tools/verification/rv/src/bpf_monitor.c
[ ... ]
> +static int handle_event(void *ctx, void *data, size_t data_sz)
> +{

[Severity: Low]
Should this callback validate that data_sz is large enough to cover the
fields accessed by read_field()?

Without verifying that the BTF metadata offsets fall within the provided
data_sz, could a truncated or malformed ring buffer event lead to an
out-of-bounds memory read?

[ ... ]
> +	if (entry[FIELD_EVENT_TYPE] =3D=3D RV_TRACE_ERROR) {
> +		printf("error ");
> +		if (config.has_id)
> +			printf(" %8"PRIu64"", entry[FIELD_ID]);
> +		printf(" %24s x %-24s\n",
> +		       get_state_name(mon_ctx, entry[FIELD_CURR_STATE]),
> +		       get_event_name(mon_ctx, entry[FIELD_EVENT]));
> +	} else {
> +		printf("event ");
> +		read_field(entry, FIELD_IS_FINAL, raw, mon_ctx);
> +		read_field(entry, FIELD_NEXT_STATE, raw, mon_ctx);
> +
> +		if (config.has_id)
> +			printf(" %8"PRIu64"", entry[FIELD_ID]);
> +		printf(" %24s x %-24s -> %-24s %c\n",
> +		       get_state_name(mon_ctx, entry[FIELD_CURR_STATE]),
> +		       get_event_name(mon_ctx, entry[FIELD_EVENT]),
> +		       get_state_name(mon_ctx, entry[FIELD_NEXT_STATE]),
> +		       entry[FIELD_IS_FINAL] ? 'Y' : 'N');

[Severity: Low]
Since get_state_name() returns a pointer to a single static buffer when
the state ID is not found, will calling it twice in the same printf
argument list cause both fields to print the exact same string as the
buffer is overwritten?

> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static int extract_enum_names(const struct btf *btf, const char *enum_ki=
nd,
> +			       char dest[][MAX_DA_NAME_LEN], struct bpf_monitor_ctx *ctx)
> +{
[ ... ]
> +		padding =3D strrchr(name, '_');
> +		name_len =3D strlen(name);
> +		if (padding && !strcmp(ctx->monitor_name, padding + 1))
> +			name_len =3D (size_t)(padding - name);

[Severity: Low]
Could this fail to strip the suffix if the monitor name itself contains
an underscore?

Since strrchr() finds the last occurrence of '_', if ctx->monitor_name
is something like my_monitor, padding + 1 will evaluate to monitor,
causing the strcmp check to fail.

[ ... ]
> +static void reset_monitor_maps(struct bpf_object *obj)
> +{
> +	struct bpf_map *map;
> +	bool err =3D false;
> +
> +	bpf_object__for_each_map(map, obj) {
[ ... ]
> +		case BPF_MAP_TYPE_HASH:
> +		case BPF_MAP_TYPE_PERCPU_HASH: {
> +			void *key =3D malloc(bpf_map__key_size(map));
> +
> +			if (!key) {
> +				err =3D true;
> +				break;
> +			}
> +
> +			while (!err && bpf_map_get_next_key(fd, NULL, key) =3D=3D 0)
> +				err |=3D bpf_map_delete_elem(fd, key);

[Severity: Medium]
Since the err flag is declared outside the loop and not reset to false
per map, does a failure to clear one map cause the while loop to be
skipped for all subsequent maps? Stale data might be left behind,
potentially causing incorrect monitor behavior.

[ ... ]
> +static struct bpf_object *open_bpf_monitor(const char *monitor_name, con=
st char *path)
> +{
[ ... ]
> +	obj =3D bpf_object__open_file(path, &opts);
> +	if (!obj) {
> +		err_msg("bpf: error opening object file: %s\n", strerror(errno));
> +		return NULL;
> +	}
> +
> +	res =3D bpf_object__load(obj);
> +	if (res) {
> +		err_msg("bpf: error loading object file: %s\n", strerror(-res));
> +		return NULL;
> +	}

[Severity: Medium]
If bpf_object__load() fails, should this error path call
bpf_object__close() to prevent leaking the bpf_object and its open
file descriptors?

[ ... ]
> +static int attach_bpf_handlers(const char *monitor_name, struct bpf_obje=
ct *obj,
> +				struct bpf_link **links, int *link_count)
> +{
[ ... ]
> +		if (access(pin_path, F_OK) =3D=3D 0)
> +			link =3D bpf_link__open(pin_path);
[ ... ]
> +int bpf_run_monitor(char *monitor_name, int argc, char **argv)
> +{
[ ... ]
> +	for (int i =3D 0; i < link_count; i++) {
> +		bpf_link__unpin(links[i]);

[Severity: Medium]
If a link is reused and reopened via bpf_link__open(), will
bpf_link__unpin() fail during cleanup?

Libbpf does not populate the internal pin_path property for reopened
links, which means the pin file could remain on the filesystem and the
BPF program might stay attached to the kernel tracepoint indefinitely
after the tool exits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D13
