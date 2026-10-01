Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27B51CF79;
	Thu,  1 Oct 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869307; cv=none; b=Gy+29LTPmGEGUsW/413QRAe+eT/uPoTlA4/Oh8FG8erBpT2mTpGUpCL4p0PVexrzXJiuUxI9PaIDXpQcQPkJX34nvzKSoxi/zeN+OoIuedZnaHMhAzPXwN1Tr0Bbl8q3AZ9JMvZ3JsGda7oOKa1LpV1hV6JcE/GFE+ool+tnx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869307; c=relaxed/simple;
	bh=V1TIXyX0gzz9LdAsF/awpveJjFjs3rzEQOYhYov7eoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ssBKEx49TvOYcm5Q8yDwoDlQ0XY6uZRmCcFdBys1KjFC2kZmetAjbgl8HFaeatBTIherkdLeHq11JnsP1titDqjGGqmtxnnDQ/22mT89j0PsUh0z+L/u1EhCaeBlyxbFis/zwX5PMn0N9kvmYm4yz5oCPJllITl0xMIPJsY02cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWDMCcJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWDMCcJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924D61F000FF;
	Thu,  1 Oct 2026 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869305;
	bh=JfPCT2TH51B8lMicqh6+V1MUS72nayYr7X4d65aAFDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iWDMCcJ/2sEGvKA+E7rZLx5GsGIEiI9hi3XkPWXgZSArXw9jWyqC+0ykJS2Byh9LE
	 azkwk4ehiV5y7mY0UQt8MA36QDEsnDliBMd6w87KX3MjqtdIXUP2+blY1A8an2XAgm
	 yUCUaaN60QUxTo1XKQTweC2726VSS45zLT/TOxVsPbp7FlLh0TFqsN7kKqC8LclKdk
	 EatcyfzUU8Md+42fKGcsWCIe2T5kPKT3fQWP+D/TslJtNq8T7A9NpOp2PXQF/uvQAR
	 yBwUimo3eau4cv9C7fe/JPbcCgR5X+tIQi5q3LwcOVDVMGB3RmiTn4cJeD30TO7hFn
	 qVHk9ZMbbtkaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/15] tools/rv: Implement BPF monitor loading and
 tracing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001152042.124445-9-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-9-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:41:45 +0000
Message-Id: <20261001154145.924D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf: path traversal allows loading arbitrary BPF objects
- [Medium] bpf: missing validation of required BTF fields leads to out-of-b=
ounds read
- [Medium] bpf: missing data_sz bounds checks in handle_event leads to out-=
of-bounds read
- [Medium] bpf: type punning in read_field violates strict aliasing
--

commit 91a3dbdeaaa49f37b21710db6d56a6658ad6fe6b
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Implement BPF monitor loading and tracing

This commit implements BPF monitor loading, execution, and optional tracing
functionality in the rv tool. It parses event and state names from BTF and
hooks into the ring buffer for output formatting.

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification=
/rv/src/bpf_monitor.c
> --- a/tools/verification/rv/src/bpf_monitor.c
> +++ b/tools/verification/rv/src/bpf_monitor.c

[ ... ]

> 		for (int j =3D 0; j < FIELD_MAX; j++) {
> 			if (strcmp(name, field_names[j]) =3D=3D 0) {
> 				ctx->field_metadata[j].offset =3D offset;
> 				ctx->field_metadata[j].size =3D size;
> 				if (j =3D=3D FIELD_ID)
> 					config.has_id =3D true;
> 				break;
> 			}
> 		}
> 	}
>=20
> 	return 0;
> }

[Severity: Medium]
Is there a need to verify that all required fields were found after this
loop?

If the BTF data does not contain a required field (like comm), its offset
in ctx->field_metadata remains 0. Later, handle_event() relies on this
offset unconditionally, which would point to the start of the payload
and result in an out-of-bounds read.

[ ... ]

> static inline uint64_t read_field(uint64_t *entry, enum field_id id,
> 				  const uint8_t *raw,
> 				  const struct bpf_monitor_ctx *ctx)
> {
> 	const struct field *field =3D &ctx->field_metadata[id];
>=20
> 	switch (field->size) {
> 	case 1:
> 		return entry[id] =3D *(const uint8_t *)(raw + field->offset);
> 	case 2:
> 		return entry[id] =3D *(const uint16_t *)(raw + field->offset);
> 	case 4:
> 		return entry[id] =3D *(const uint32_t *)(raw + field->offset);

[Severity: Medium]
Does casting a const uint8_t * byte pointer to larger scalar types like
uint32_t * violate strict aliasing rules?

The tools directory is compiled with -fstrict-aliasing enabled, so this type
punning can result in undefined behavior and miscompilation.

Also, is it possible for the offset + size to exceed the data_sz provided
by the ring buffer? read_field() dereferences memory based purely on
BTF offsets without validating that the access fits within the actual
payload size.

[ ... ]

> static int handle_event(void *ctx, void *data, size_t data_sz)
> {
> 	struct bpf_monitor_ctx *mon_ctx =3D ctx;
> 	const uint8_t *raw =3D data;

[Severity: Medium]
Is the data_sz parameter ignored in this function?

If a BPF program submits a truncated event to the ring buffer, the missing
bounds checks in this function and read_field() could lead to out-of-bounds
memory reads.

[ ... ]

> 	comm =3D (const char *)(raw + mon_ctx->field_metadata[FIELD_COMM].offset=
);
> 	read_field(entry, FIELD_CURR_STATE, raw, mon_ctx);
> 	read_field(entry, FIELD_EVENT, raw, mon_ctx);
>=20
> 	printf("%16s-%-8"PRIu64" [%.3"PRIu64"] ", comm, entry[FIELD_PID], entry[=
FIELD_CPU]);

[Severity: Medium]
Could this printf() format specifier lead to unbounded memory reads?

Using %16s instead of %.16s allows printf to read indefinitely until it
encounters a null byte. If the string is not null-terminated or was absent,
this might read beyond data_sz.

[ ... ]

> static int find_bpf_file(const char *subdir, const char *name, char *path=
_out, size_t path_len)
> {
> 	char path[MAX_PATH];
>=20
> 	for (int i =3D 0; bpf_base_paths[i][0]; i++) {
> 		size_t size =3D snprintf(path, sizeof(path), "%s/%s/%s.o",
> 				       bpf_base_paths[i], subdir, name);
>=20
> 		if (size < MAX_PATH && access(path, R_OK) =3D=3D 0) {

[Severity: High]
Can a malicious user supply a name containing path traversal characters like
../../../ to load arbitrary object files?

The user-controlled monitor_name is passed to find_bpf_file() and blindly
appended to the path string. If an administrator configures sudo to allow
running rv mon, an attacker could exploit this traversal to load their
own BPF program and gain arbitrary kernel code execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001152042.1244=
45-1-gmonaco@redhat.com?part=3D8
