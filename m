Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2687638A71F;
	Sun,  6 Sep 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717672; cv=none; b=uMPGN03EwNgaLZi+7WS4h7a+MacnMsfzIMbm728zqKUPlzFGWfEzg7P/Q5AD8bZv35JJJODKR45nsArMmKcznxsc8EJHFiCZofcjTMZ5MY3ie4kAQy0gUzXAraQGYMgNpLIeH7WYZfVWybxOlKAwDzUIfXJWNc+t5KBW9CVo3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717672; c=relaxed/simple;
	bh=f3qcTU73oR962ZY/FyxCCViRe18VgRoMcPMd6wAfnT0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iAaPbHGfVmImZ5Urcf6wmw0xyJRNqVlOTowM7wMHKzn5d9I7Ma1ZADp7HAcBlX/U17w9UviMMxeRrLPJpgCKF3MQPR+4QcgLQQQ+yTnNUEGIu1QPmcgdCz0r4mnylAn0zYI/l0V+ygoE3nGwWxkiTetUcoU5d0JIPFi7tgMLBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMStPk/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMStPk/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4DC1F00A3A;
	Sun,  6 Sep 2026 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717670;
	bh=0u/E9k5ilzUqi87q47P7mB8P7PBButvS7p/Zv+nkDbs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nMStPk/C08IpmxeEnHlsnpH5+JYWwBVoJOMJ4u/Pr3de0MbG1W0vVpW9LrR8g/E0t
	 ItyhPZf9c8AqOj5eEI0P5mrtj/5nE/ZzXgj/Cf7zPga/Ks+b9eAOiu9P4soHCBLxdX
	 +dgvDtJXdtZBLVeZOsC+nyc513wGkDzGvtsO97cAc2gziSAMDARPRTtalQnOAVT13z
	 E90vjq6xgiPqQPM8LTvMD7HxqJxLf5AewHOwEbGDkEtTcl/OumGRvdTa3EAitNUUYH
	 v1fi5nTa14rxl6QOmD3goszTK8DqG71vc7zVZ0grTLHV/WdqGKrJ494yW93jDdXkkn
	 /uzdg2R7oMfFQ==
Content-Type: multipart/mixed; boundary="===============2084893239028443890=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <12b73f2a5fb57336f0238240607d7bbff24bb274df375cb4788556d7d6756bf5@mail.kernel.org>
In-Reply-To: <20260906170819.1212661-3-hi@tychen.cc>
References: <20260906170819.1212661-3-hi@tychen.cc>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Check bpftool batch map dump contents
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  6 Sep 2026 18:01:09 +0000 (UTC)

--===============2084893239028443890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Check bpftool batch map dump contents
>
> Exercise hash map dumps around the initial batch size and across
> multiple batches, including empty and single-entry maps. Compare each
> complete unordered key/value set with the input data in plain, JSON
> and pretty JSON output.
>
> Cover one-byte keys, three-byte values and BTF-formatted maps to catch
> cursor sizing, buffer alignment and formatting regressions.

The changelog, the file name and the subtest names all describe a batched
map-dump implementation that does not exist in the code under test.

bpftool map dump is implemented by map_dump() in tools/bpf/bpftool/map.c,
which walks the map one element at a time:

    while (true) {
        err = bpf_map_get_next_key(fd, prev_key, key);
        if (err) { ... break; }
        if (!dump_map_elem(fd, key, value, info, btf, wtr))
            num_elems++;
        prev_key = key;
    }

and dump_map_elem() calls bpf_map_lookup_elem() per key.

grep -rn 'batch\|BPF_MAP_LOOKUP_BATCH\|bpf_map_lookup_batch'
tools/bpf/bpftool/ returns only the unrelated bpftool batch file FILE
subcommand in main.c. There is no bpf_map_lookup_batch() call, no batch
cursor (in_batch/out_batch), no per-batch buffer and no batch-size
constant anywhere in bpftool.

What does this mean for the test?

- "around the initial batch size", "across multiple batches" and "cursor
  sizing, buffer alignment" describe nothing in the tested code. The
  counts 255/256/257/1025 and the subtest names below_batch, exact_batch,
  above_batch, multiple_batches are arbitrary; 256 is not a boundary of
  any code path.

- The file name bpftool_map_batch.c and the test name bpftool_map_batch
  collide with bpftool's real, unrelated batch subcommand (bpftool batch
  file FILE, main.c:334 do_batch()), so a reader looking for coverage of
  that subcommand will find a map-dump test instead.

- The series range 407ec415f849..1dcddb9351e8 contains no commit
  converting map dump to the batch API (the only other change is
  map_perf_ring.c ring-buffer support in c23648f76644), so this is not
  infrastructure landing ahead of its user.

What the test actually does is valid and useful - it verifies the exact
plain/JSON/pretty-JSON rendering of map dump for various key/value sizes
and element counts. Should the changelog and naming describe that (e.g.
"check map dump output contents") instead of claiming batch-boundary
coverage, so a future maintainer doesn't believe the batch paths are
covered when they are not?

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
> new file mode 100644
> index 000000000000..139d13a49dce
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c

[ ... ]

> @@ -0,0 +1,186 @@

[ ... ]

> +void test_bpftool_map_batch(void)
> +{
> +	static const struct dump_case cases[] = {
> +		{ "empty", 0, 4, 4 },
> +		{ "single", 1, 4, 4 },
> +		{ "below_batch", 255, 4, 4 },
> +		{ "exact_batch", 256, 4, 4 },
> +		{ "above_batch", 257, 4, 4 },
> +		{ "multiple_batches", 1025, 4, 4 },
> +		{ "one_byte_key", 256, 1, 4 },
> +		{ "odd_value_size", 257, 4, 3 },
> +		{ "btf_empty", 0, 4, 4, true },
> +		{ "btf_single", 1, 4, 4, true },
> +		{ "btf_multiple_batches", 1025, 4, 4, true },
> +	};

A subsystem pattern flags this as potentially concerning: the new test
file is structured around an internal batching strategy rather than the
interface it actually checks. Four of the eleven cases exist only to
straddle a supposed 256-element batch boundary (below_batch, exact_batch,
above_batch, multiple_batches), and the changelog names "cursor sizing"
and "buffer alignment" as the regressions being guarded.

map_dump() in tools/bpf/bpftool/map.c uses bpf_map_get_next_key() +
bpf_map_lookup_elem() per element, so no such boundary exists and these
cases are indistinguishable from any other element count. The
interface-level part of the test (exact plain/JSON/pretty-JSON record
text, element count footer, BTF formatted field) is sound and is what the
case table should be organised around.

The guide directive notes: a new selftest file added for a narrow variant
(a specific size, a specific internal code path) of behavior an existing
test in the same directory already covers more generally should be
reported as a concern - asking whether it should be a new case in the
existing test instead. Tests written against specific implementation
details (an internal batching strategy, a particular code path taken to
reach a result) break or need a rewrite whenever that implementation
changes.

That said, the assertions themselves are written against observable
bpftool output, not against internal state, so the test will not break if
bpftool's enumeration strategy changes - only the case names and the
changelog would become misleading. Adding extra element counts is also
harmless coverage.

Does the case table organization based on a non-existent batch boundary
make the test harder to maintain or extend?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34048930508
--===============2084893239028443890==--
