Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B138B7DD
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252944; cv=none; b=VdBO6eZn7J1lg9LC4bhlihcJ54xyNpU/3dmwOFzWXnQIgQOeh3BIFkqbEXStLIEUWLt/tulmBdrzKgpH2aKlPYKGG4MKLTjFtnNU7H3BlghVabiiAHPhcNOWs8GEf7sauDSzkAww9LBCyulXDzSwLOgfyaq6I6nq64gOg+OGEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252944; c=relaxed/simple;
	bh=d2OyGDORpx50A9YYiopEC5vIXBOAsMPohaqMIoA7/CU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPJkBpui8y4p1ihMnQCMiJ+GbrDT+wkVJ+GRdrAo5nE8vJBpFsnVlCLVOpOXv11jv6l12g9PFZVmZxb1S6DFN0srG41yLMyKe4mXnKfED8VqkDfsOljEBvAIz6gyGZ3MnLhCxTVkmGnflMtJXqKPSYOcVniY/CP+0Mnrjb2gtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiOCvGAX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiOCvGAX"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so239224a12.3
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787252942; x=1787857742; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VG6RiuKlDCdmyIDySvb3VeOenzZGZ8iauUzX0sgEUNc=;
        b=AiOCvGAXRRg/vnnVpYLRMKzc1Y7CBzTN5tLFeMbwyxIdLwujgBmKT63RyPDPFrLY5S
         v0cU5bxUVyCWGOYQFKNDebgUUJgKz9S1UEVEAsOTgL4OapRdm59Jmi3UZpO2wrelUUpy
         d3fjwmQvipUFoFAPFrJz3GH8DQg/aCk6FHHBRv1ylGjLUBczVDGaY3FoibWICoC0xNEt
         7Ym2COrbYxxXaAlJiGXc8RRfUgpGV+cjck2tiiY20938xG0C3eLDKl4yZIIu+ltzkHqy
         3nSAQ4X5ZbxXE2TlAkkcXVBixbIQkeAuQ+PBBWpz1C/59ZwwL/7YcLTuhQ6/bw++KGWp
         A3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787252942; x=1787857742;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VG6RiuKlDCdmyIDySvb3VeOenzZGZ8iauUzX0sgEUNc=;
        b=PKE/QUqHF8AA0ga+oaUbWJPpqQFDrOKAeb/IdY04MMGaVijjpWmOdHD2vPLqutoFAe
         O+10sh5Gew8XrS86kB94AQIUDV9wVdUjrIgk17O+54EFZhuzcIT+TcfrewyaxkeKJcPS
         fKyPQTBo2c1LG/lGuugCCvRvTg1EBOpq59HtYTotsjugOcsnkz/B/sGereoWwEIz0VbR
         FQC0A/R+zhiQVUbDewKuQwaZcIk36fYXLCqFdKOEpx4Kkkhm2B1UXDD1GVLPKk5nZmEd
         BznfDzoHIdJ1KHzF2cYqevCwh5zxbDaQNsFKai7eAfCV2+npf/HDBclMN4LPXIaRTh1Q
         8L9g==
X-Gm-Message-State: AOJu0Yw3m7y3OboZYbwc6VVhPlL4AmJsKhLpK3dPxnVZKRiZ2MB5FP8O
	ZvyibZtt0kDSjkJhgSUaK44ElhdCaHEZO6T5ImatNm4+hpI1Yd+VP65h
X-Gm-Gg: AR+sD112gZi+5/9UzFXiHl1ybqbM0Exc1tZkD8oAgnxzK0JlxgKUM8k01ILiGsZsE9U
	CTzTOe/XKy6kKVJplrwySNQSRjDiugOHvDhNPtFBs4waElDzbL7o2m/TBj8Ezj5euVZSTrsFa8z
	1emPmhO6OsN/85X9v16h+gBWa7bVXzRAG6KQsA2/fJ+T92lphUaIJo1NUF7mUMrRo2FjKGokemU
	Xuf5Sb8MB5XWsG/czb/7zjgK2Moc+BKTIY4UZ1F0SVO+6nTfBENZoVVvNYJ+BZlCUJWRnLHISh3
	NWWa304ro54X6FNnLZuDFaLAmLs+B8Uo6Hlhh4sWVBwXYBgSuLPISOd8pDslozWy+/KefWrdmqX
	JPZaZpS0qfW3/eT//c/ibX4DLnp7RmuDJg2Y+J48UjauPIFYuYsbvte7YMiJqA7gWtAYPc898sc
	qCFKqu35+aB7N9cNEYjcA1xALgdq/so9aLkTVEU9qtzz9fMpxtmDCvoPgX4ULTwktNO8n260I+p
	UMqxv1FzIr5h+zMwN9fAgiW399j4fEXsQ8kPoA1XxRrjA==
X-Received: by 2002:a05:6a21:1786:b0:3cc:ebeb:3efe with SMTP id adf61e73a8af0-3cd2ffc3d9emr1283127637.9.1787252942179;
        Thu, 20 Aug 2026 12:09:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad3dd15sm16806129c88.2.2026.08.20.12.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 12:09:01 -0700 (PDT)
Message-ID: <186766fa22a79cfbdf72ee51494004e91cccebee.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] selftests/bpf: Add tests for bpftool
 btf dump format c
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Date: Thu, 20 Aug 2026 12:09:00 -0700
In-Reply-To: <20260820000627.3826188-3-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
	 <20260820000627.3826188-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 17:06 -0700, Ihor Solodrai wrote:
> "bpftool btf dump format c" generates the vmlinux.h that BPF programs
> are built against, and it has no test coverage at all. The only
> in-tree consumers are build systems, and none of them diff the result.
>=20
> Building against the header only catches what a compiler rejects.
> Missing macros, a missing preserve_access_index pragma and the wrong
> padding width all compile.
>=20
> Add a test for those three, over both sort orderings.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../bpf/prog_tests/bpftool_btf_dump.c         | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_btf_du=
mp.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/=
tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> new file mode 100644
> index 000000000000..53bb7065b3ca
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpftool_helpers.h>
> +#include <bpf/btf.h>
> +#include <unistd.h>
> +
> +#define DUMP_BUF_SZ	(16 * 1024)
> +
> +static int btf_to_tmpfile(struct btf *btf, char *path, size_t path_sz)

Nit: let's drop path_sz and assume PATH_MAX.

> +{
> +	const void *raw;
> +	ssize_t written;
> +	__u32 sz;
> +	int fd;
> +
> +	raw =3D btf__raw_data(btf, &sz);
> +	if (!ASSERT_OK_PTR(raw, "raw_data"))
> +		return -1;
> +
> +	snprintf(path, path_sz, "/tmp/bpftool_btf_dump.XXXXXX");
> +	fd =3D mkstemp(path);
> +	if (!ASSERT_OK_FD(fd, "mkstemp"))
> +		return -1;
> +
> +	written =3D write(fd, raw, sz);
> +	close(fd);
> +	if (!ASSERT_EQ(written, sz, "write_btf")) {
> +		unlink(path);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static char *dump_c(const char *path, bool sorted)
> +{
> +	char args[MAX_BPFTOOL_CMD_LEN];
> +	char *buf;
> +	int err;
> +
> +	buf =3D malloc(DUMP_BUF_SZ);
> +	if (!ASSERT_OK_PTR(buf, "alloc"))
> +		return NULL;
> +
> +	snprintf(args, sizeof(args), "btf dump file %s format c%s",
> +		 path, sorted ? "" : " unsorted");
> +	err =3D get_bpftool_command_output(args, buf, DUMP_BUF_SZ);
> +	if (!ASSERT_OK(err, "dump")) {
> +		free(buf);
> +		return NULL;
> +	}
> +	return buf;
> +}
> +
> +/*
> + * struct holey { int c; <32 bit hole> int tail; };
> + *
> + * One record with a hole, and a 4-byte long to pad it with. How records
> + * themselves are rendered is already covered by the build, so the fixtu=
re does
> + * not need to be more elaborate than that.
> + */
> +static struct btf *mk_btf(void)
> +{
> +	struct btf *btf;
> +	int id, err;
> +
> +	btf =3D btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "new_empty"))
> +		return NULL;
> +
> +	id =3D btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +	if (!ASSERT_EQ(id, 1, "int"))
> +		goto err_out;
> +
> +	id =3D btf__add_int(btf, "long int", 4, BTF_INT_SIGNED);
> +	if (!ASSERT_GT(id, 0, "long"))
> +		goto err_out;
> +
> +	id =3D btf__add_struct(btf, "holey", 16);
> +	if (!ASSERT_GT(id, 0, "struct_holey"))
> +		goto err_out;
> +
> +	err =3D btf__add_field(btf, "c", 1, 0, 0);
> +	if (!ASSERT_OK(err, "holey_c"))
> +		goto err_out;
> +
> +	err =3D btf__add_field(btf, "tail", 1, 96, 0);
> +	if (!ASSERT_OK(err, "holey_tail"))
> +		goto err_out;
> +
> +	btf__set_pointer_size(btf, 4);

Nit: I think the approach taken by btf_distill.c:test_distilled_base()
     is a bit better, it drops verbose error checks after each btf__*
     constructor call and calls VALIDATE_RAW_BTF() instead.
     This is both concise and self-documenting.

> +
> +	return btf;
> +err_out:
> +	btf__free(btf);
> +	return NULL;
> +}
> +
> +/*
> + * Check only what the selftests build cannot:
> + *   - bpf_helpers.h defines __ksym and __weak as well, and no program u=
ses
> + *     __bpf_fastcall, so losing the macro block changes nothing;

The above bullet point does not make sense.

> + *   - building without the preserve_access_index pragma is a supported =
mode
> + *     (BPF_NO_PRESERVE_ACCESS_INDEX), so losing it only costs CO-RE;
> + *   - the padding width comes from the BTF's pointer size, and a native=
 build
> + *     never runs the host bpftool over a differently sized target's BTF=
.

Please make these two inline with actual asserts,
also "... so losing it only costs CO-RE" is completely out of context here.

> + */
> +static void test_dump(const char *path, bool sorted)
> +{
> +	char *buf;
> +
> +	buf =3D dump_c(path, sorted);
> +	if (!buf)
> +		return;
> +
> +	ASSERT_HAS_SUBSTR(buf, "#define __ksym __attribute__((section(\".ksyms\=
")))",
> +			  "ksym");
> +	ASSERT_HAS_SUBSTR(buf, "#define __weak __attribute__((weak))", "weak");
> +	ASSERT_HAS_SUBSTR(buf, "#define __bpf_fastcall __attribute__((bpf_fastc=
all))",
> +			  "bpf_fastcall");
> +
> +	ASSERT_HAS_SUBSTR(buf, "#ifndef BPF_NO_PRESERVE_ACCESS_INDEX", "pai_gua=
rd");
> +	ASSERT_HAS_SUBSTR(buf,
> +			  "#pragma clang attribute push (__attribute__((preserve_access_index=
)), apply_to =3D record)",
> +			  "pai_push");
> +	ASSERT_HAS_SUBSTR(buf, "#pragma clang attribute pop", "pai_pop");
> +
> +	ASSERT_HAS_SUBSTR(buf, "long: 32;", "target_ptr_size");
> +
> +	free(buf);
> +}
> +
> +void test_bpftool_btf_dump(void)
> +{
> +	char path[PATH_MAX];
> +	struct btf *btf;
> +
> +	btf =3D mk_btf();
> +	if (!btf)
> +		return;
> +	if (btf_to_tmpfile(btf, path, sizeof(path)))
> +		goto out;
> +
> +	if (test__start_subtest("c_sorted"))
> +		test_dump(path, true);
> +	if (test__start_subtest("c_unsorted"))
> +		test_dump(path, false);
> +
> +	unlink(path);
> +out:
> +	btf__free(btf);
> +}
