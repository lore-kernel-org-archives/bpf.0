Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388899;
	b=WYzJEzHt5m/He/Cm9yXkN/lZtDsnI9cPBmzQWiEwfkMoVXyXhSWemxpsAX+gBOH8KbAy
	 cAIIfX/iLk+D9YyGYQABsoLfTS/MpGPTVbNIezXitzL8LgskNAzHFlz67TEqwuLV8zpLw
	 bjjGfYYgpIjDGCrwaaWhlOWpmFbF13V5NqtpB+35EgHovdz4RzJMam/y2UXv0487HyUX7
	 /fDjqFTxFWtTZFf1EHh4YaP0uijgORA3kr5zjiSOOZA0nlcEW3FtcqHrhaZoPM3/VCQ1q
	 cD38fQho0k5P7QJkgBxsg722jyXA+YWR+n2Yk6qfv4hkSIj9NP3ol44aWOFDnjmpymg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388899;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=crQRzA1NZRP9Kane1rHo0PkkqJUfG1/DLCkh3lApae8=;
	b=haQXuwOVly6SAtyVvw68J3OlMd6VYnz9FSmbMOLJo5M3r+2ItmiNJwXbQCGI8cQJEc38
	 vGtJiAmgoOBOKpcAPbgbF0jPC8Yt2MMYk5FMaj0igPgKRqDd2TImhwD1qvFcMp3q98Hzn
	 iH3HCZDU/VVMPoPNyO8wpdC86yICJ5lCDI+Fw1O5aJ+ZDlAAN1foIVCfLE0dWrlzQofQq
	 V7+BLyfSD9eu3R2dFATnGfYYf8LwOVjAsrK/J41r0WleK8bbuUXVHsdXxlCJZx3PpU94w
	 pEu2T03bIHSgy9lzeViYuQnd6fSOZvv5ZekXPGMEzdSh98E5uF401ubcrHDi42Be2VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv64Q36d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65C606A31C;
	Fri, 30 Oct 2026 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv64Q36d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D141F000C1;
	Fri, 30 Oct 2026 19:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793388898;
	bh=crQRzA1NZRP9Kane1rHo0PkkqJUfG1/DLCkh3lApae8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lv64Q36dqcfNzh9rv+WZ16OOePlRH6JNyTyhtKgdajymrh/a6wJkIxQKelCoEpCG8
	 K2NBflVPluGAlDJJ2swH25jXWDWOP4L7LAOUbjA4jnzZ1jgPCXu6Bi1wbxYPh+OUuf
	 4pdLu7cVa2M2/0ls6FV6C5o60me2UUMxN301lcahnwnMTBVPQAJMMAOmjiiiJwmTfC
	 PmTui3Qtkx0jEoxWBXLWf9P5eo7HivRwmVMwcf6RKv4eby6q9gfjGE8nmL/zr5bJnP
	 JilI3c50W9J2qggRmcNVnNGPmIRpiMohfOiB76OcU2CRIJIowq2wFrUPDRyy0icpHB
	 VRXI88NVcfgsg==
Content-Type: multipart/mixed; boundary="===============1483456430051234551=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <09475f69602098aa106af66960f75de688d53ca24efdf8dcdc6f91c0d2a59c6e@mail.kernel.org>
In-Reply-To: <20261030-ftrace_in_test_progs-v1-1-aa50c5dd1ccc@bootlin.com>
References: <20261030-ftrace_in_test_progs-v1-1-aa50c5dd1ccc@bootlin.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: add helpers to manipulate ftrace
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 19:34:58 +0000 (UTC)

--===============1483456430051234551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: add helpers to manipulate ftrace

TL;DR: Restoring ftrace filters in trace_helpers.c may abort on a saved line
over 126 bytes (128-byte buffer), leaving the filter empty, so all functions
get traced and global ftrace state isn't restored.

> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index 6d7a4b8c4ab8..1f26a057a810 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c

[ ... ]

> +#define CHUNK_SIZE	128

[ ... ]

> +static const char *tracefs_next_line(const char *content, char *buf, size_t size,
> +				     int *err)
> +{
> +	const char *end;
> +	size_t len;
> +
> +	*err = 0;
> +	while (*content) {
> +		end = strchrnul(content, '\n');
> +		len = end - content;
> +		content = *end ? end + 1 : end;
> +
> +		if (!len || end[-len] == '#')
> +			continue;
> +
> +		if (len + 2 > size) {
> +			*err = -ENAMETOOLONG;
> +			return NULL;
> +		}
> +		memcpy(buf, end - len, len);
> +		buf[len++] = '\n';
> +		buf[len] = '\0';
> +		return content;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int tracefs_restore_file(const struct tracefs_ctl_entry *entry)
> +{
> +	char buf[CHUNK_SIZE];
> +	const char *content = entry->old;
> +	int err = 0;
> +
> +	if (!content)
> +		return 0;
> +
> +	if (entry->kind == TRACEFS_CTL_FILTER) {
> +		err = tracefs_write_file(entry->path, "");
> +		if (err)
> +			return err;
> +	}
> +
> +	while ((content = tracefs_next_line(content, buf, sizeof(buf), &err))) {
> +		err = tracefs_write_file(entry->path, buf);
> +		if (err)
> +			return err;
> +	}
> +
> +	return err;
> +}

Can a saved line longer than 126 bytes abort the restore here?

tracefs_restore_file() splits the saved content into a buffer sized by the
read chunk constant:

	char buf[CHUNK_SIZE];     /* CHUNK_SIZE is 128 */

and tracefs_next_line() fails the whole restore with -ENAMETOOLONG when
len + 2 > size.  The kernel can print much longer entries than that.
print_rec() emits the full symbol (KSYM_NAME_LEN is 512) plus the
" [module]" suffix, so mangled Rust symbols or long C names with a module
suffix can exceed 126 bytes.

For TRACEFS_CTL_FILTER entries the file has already been emptied by
tracefs_write_file(entry->path, "") before the long line is reached:

	if (entry->kind == TRACEFS_CTL_FILTER) {
		err = tracefs_write_file(entry->path, "");
		...
	}
	while ((content = tracefs_next_line(content, buf, sizeof(buf), &err))) {

so the restore stops part-way, every entry after the long line is lost, and
if none were restored yet the filter is left empty.  For set_ftrace_filter
an empty filter means all functions are traced, which is the opposite of
the original restriction, and the global ftrace state is not restored.

Should the line buffer be sized to the actual line length (or should the
content be written straight from the saved string) instead of being tied to
CHUNK_SIZE?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41113297251
--===============1483456430051234551==--
