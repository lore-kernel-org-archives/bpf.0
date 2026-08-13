Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691B36A03F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660906; cv=none; b=mqR8v/0afs4ll36409SVRJBh1ZSNVXf1DiBupe95qBvtl/bLRMwm+YRpYCt9IJpnmlE9B2LTB5uG6Dmq73Mx9IC8Xd/haRUjAbqLefnkSoZ1JWN1Xv89MYsFWhLz+7yCkdy9C+cFt+cJHS5Qj8wuo+h6QaNu/KZUuElYTKeRo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660906; c=relaxed/simple;
	bh=tFtwmtN7Fzb4AN0l+iSwfeMFlRd7ZMEYSx6kJ7/aYuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGiXy9rEWKCgalFiy8yQRZ/8ezqXc6VsdQLextnSv2710Y3UbT66Y127lXMgy68dYRcuGcAuc/RWov0xrnUDm9SWE1R24WzFWl8cT8lp4siP8IRPfIlLS7aw8snN4cgupKxqdxeNpxTruhd+bb/Hrs4o0FgPyFY++knuBVN+goU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJOKXJIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJOKXJIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BC51F000E9;
	Thu, 13 Aug 2026 22:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786660905;
	bh=KWjNmgiJhk29RAO4vQbvjt8CszZPrl3kCZKY7HhjpzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJOKXJIGfR2SnD3cjf8OFHcFk2kh/ZYbysN0FibwZ5pMB/i3U4t4BTRzJy3FhcuYH
	 5OCM3cx6q5pLKUDOSAmOdjsPYfvR3XE2wUlnCtqQdJr8nwpR+hNcUpDrDXE/0QI6iv
	 KDiULeq6z3R0iDhhapHKAbzbCVg8H9N3o3ldaDKMHA+zTPzRqNYh9WjHpU1vBoRyfr
	 +KCnHYnUb3lh4BuvSj/Nuxc7ov2ip20OqaGIeYmuqZqs6stU7CsFM/cjPhamEBiSQJ
	 G9hHbFVdf/RWqohYoV7KzmUgsRlGp/O5GKq7G6822G8NoeM/3rtYEQCAarX1K8N23O
	 QdI9I6kJ78clw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 12/13] tools/kexec: Introduce a bpf-prog to handle UKI
 image
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pingfan Liu" <piliu@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260322014402.8815-13-piliu@redhat.com>
References: <20260322014402.8815-13-piliu@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:41:33 +0000
Message-Id: <20260813224145.42BC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Integer overflow in PE section bounds checks allows out-of-bounds =
kernel memory reads.
- [High] BPF Verifier rejection and runtime failure due to out-of-bounds st=
ack read in section name comparison.
- [High] MAX_RECORD_SIZE rigidly restricts UKI size, erroneously rejecting =
almost all valid real-world UKI binaries.
- [Medium] Missing error handling for bpf_probe_read_kernel allows silent p=
ropagation of empty payloads.
- [Medium] PE parsing uses native endianness, breaking kexec UKI support on=
 Big Endian architectures.

Pre-existing issues:
- [High] The bpf_buffer_parser kfunc lacks the required __sz annotation, ca=
using verifier rejection.
--

--- Patch [12]: [PATCHv7 12/13] tools/kexec: Introduce a bpf-prog to handle=
 UKI image ---
commit 0509f42d83cdb5ef64ae7388052bbc638cf2e7d6
Author: Pingfan Liu <piliu@redhat.com>

tools/kexec: Introduce a bpf-prog to handle UKI image

This commit adds a BPF program to parse Unified Kernel Image (UKI) PE files
for kexec. It extracts the .linux, .initrd, and .cmdline sections from the =
PE
file and passes them as commands to the kexec parser pipeline.

> diff --git a/tools/kexec/uki_parser_bpf.c b/tools/kexec/uki_parser_bpf.c
> new file mode 100644
> index 0000000000000..1eb542d8acd4c
> --- /dev/null
> +++ b/tools/kexec/uki_parser_bpf.c
> @@ -0,0 +1,235 @@
[ ... ]
> +/* ringbuf 2,3,4 are useless */
> +#define MIN_BUF_SIZE 1
> +#define MAX_RECORD_SIZE (IMAGE_SIZE + 40960)

[Severity: High]
Does this 40KB margin over IMAGE_SIZE reject valid UKI images that contain
standard initramfs payloads?

If a typical initramfs is 10MB to 50MB, will checking the file size or sect=
ion
size against MAX_RECORD_SIZE prevent almost all real-world UKI files from
loading?

[ ... ]
> +static int fill_cmd(char *buf, __u32 cmd_word, __u32 pipeline_flag,
> +			const char *src, __u32 data_len)
> +{
[ ... ]
> +	if (!src || !data_len)
> +		return sizeof(*hdr);
> +	if (data_len > MAX_RECORD_SIZE - sizeof(struct cmd_hdr))
> +		return -EINVAL;
> +	bpf_probe_read_kernel(payload, data_len, src);

[Severity: Medium]
What happens if bpf_probe_read_kernel fails due to an unmapped page?

Since the return value is ignored, will it silently pass a zero-filled buff=
er
as a successful payload instead of failing explicitly?

> +
> +	return sizeof(*hdr) + data_len;
> +}
> +
> +static int process_uki_pe(const char *pe_buf, __u32 pe_sz, char *scratch,
> +			  struct bpf_parser_context *bpf_ctx)
> +{
> +	__u32 pe_offset, pe_sig, section_table_off;
> +	__u16 dos_magic, num_sections, opt_hdr_sz;
> +	__u16 pipeline_flag =3D 0;
> +	int i, ret;
> +
> +	if (pe_sz < 64)
> +		return -EINVAL;
> +	if (pe_sz > MAX_RECORD_SIZE)
> +		return -EINVAL;

[Severity: High]
This check uses the same MAX_RECORD_SIZE that may reject valid UKI images
containing typical initramfs sizes.

> +
> +	if (bpf_probe_read_kernel(&dos_magic, sizeof(dos_magic), pe_buf) < 0)
> +		return -EIO;
> +	if (dos_magic !=3D 0x5A4D)

[Severity: Medium]
Will this endian-specific comparison fail on Big Endian machines?

Since the PE format is strictly Little Endian, should this use an endianness
conversion helper to avoid rejecting valid PE files on Big Endian
architectures?

> +		return -EINVAL;
> +
> +	if (bpf_probe_read_kernel(&pe_offset, sizeof(pe_offset),
> +				  pe_buf + 0x3c) < 0)
> +		return -EIO;
> +	if (pe_offset + 24 > pe_sz)

[Severity: High]
Is it possible for pe_offset + 24 to overflow 32-bit math?

If a maliciously crafted UKI provides a very large pe_offset, could the
addition wrap around and bypass the pe_sz boundary check, allowing
out-of-bounds kernel memory reads?

> +		return -EINVAL;
> +
> +	if (bpf_probe_read_kernel(&pe_sig, sizeof(pe_sig),
> +				  pe_buf + pe_offset) < 0)
> +		return -EIO;
[ ... ]
> +		pipeline_flag =3D 0;
> +		if (__builtin_memcmp(sec_name, linux_sect_name, sizeof(linux_sect_name=
)) =3D=3D 0) {
> +			subcmd =3D KEXEC_BPF_SUBCMD_KERNEL;
> +			/*
> +			 * .linux section may contain different format kernel, which should be
> +			 * passed to the next stage to handle
> +			 */
> +			pipeline_flag =3D KEXEC_BPF_PIPELINE_FILL;
> +		}
> +		else if (__builtin_memcmp(sec_name, initrd_sect_name, sizeof(initrd_se=
ct_name)) =3D=3D 0)
> +			subcmd =3D KEXEC_BPF_SUBCMD_INITRD;
> +		else if (__builtin_memcmp(sec_name, cmdline_sect_name, sizeof(cmdline_=
sect_name)) =3D=3D 0)

[Severity: High]
Does this force a 9-byte read from the 8-byte sec_name array?

Since cmdline_sect_name is a null-terminated string, its sizeof is 9 bytes.
However, sec_name is allocated as an 8-byte array on the stack. Will this
cause the BPF verifier to reject the program due to an out-of-bounds stack
read?

Also, the .cmdline section name in a valid PE file is exactly 8 bytes and
lacks a null terminator, so would this comparison always fail at runtime?

> +			subcmd =3D KEXEC_BPF_SUBCMD_CMDLINE;
> +		else
> +			continue;
> +
> +		if (bpf_probe_read_kernel(&raw_size, sizeof(raw_size),
> +					  pe_buf + shdr_off + 16) < 0)
> +			continue;
> +		if (bpf_probe_read_kernel(&raw_off, sizeof(raw_off),
> +					  pe_buf + shdr_off + 20) < 0)
> +			continue;
> +
> +		if (!raw_size || raw_off + raw_size > pe_sz)

[Severity: High]
Is it possible for raw_off + raw_size to overflow 32-bit math?

Similar to pe_offset above, if raw_off is huge and raw_size is small,
could it wrap around, bypass the > pe_sz check, and result in an arbitrary
out-of-bounds kernel memory read in fill_cmd?

> +			continue;
> +
> +		ret =3D fill_cmd(scratch,
> +				MAKE_CMD(KEXEC_BPF_CMD_COPY, subcmd),
> +				pipeline_flag,
> +				pe_buf + raw_off,
> +				raw_size);
> +		ret =3D bpf_buffer_parser(scratch, ret, bpf_ctx);

[Severity: High]
This is a pre-existing issue, but does the bpf_buffer_parser kfunc need its
size argument renamed to buf__sz to satisfy the BPF verifier?

The bpf_buffer_parser kfunc is defined with the argument name buf_sz.
The verifier strictly requires memory buffer size arguments to end in __sz.
Because it is named buf_sz, will the verifier fail to grant KF_ARG_PTR_TO_M=
EM
semantics and reject the ringbuf memory passed here?

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260322014402.8815=
-1-piliu@redhat.com?part=3D12
