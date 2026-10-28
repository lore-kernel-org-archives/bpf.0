Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199451;
	b=1e90//mQaE9DiMfJasMtd/ykpEZFQzzm8daFV9NHx3UC/YoM9ia4iUEz4n3f/YjguXtT
	 G/3EbVjNA/XZIvfqjrJA0IVxIskCUjn5ebueJh0OaumN9l1Khc1yMvisXkaRjlbQPCyeu
	 qF2NwXYDd7SFa8PjQpQkDe0aXMSpCh6B5zhclhiRrRiqpsei4MYSKeiB4VBO0iw/Bhggi
	 xAxZoRkPAXHMNGDfjwzVVohsi3/D12AQFbHTiOK9Ctyt3rwKLxV99dxPmljs0kCU/+Wdg
	 r4GKlGTEToeDieBBn0UmWAeutw1gspU6ob+I5GRG8R2DHLHqzYWaeeyfLxeJB4n/IjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+DrCiC52JWwqxpsEOb10usl2t2DGPyucFM5gOQI8SGI=;
	b=TLdiZWPSAl3nGA7g0Ked644U/ZWpa3PJHqWMpuk9LW0qj06lnKoosBFI1SY8E02i0KBt
	 iEh01H1fLgjvLMrqF/Ko3K+JcmbQUVixltPWKJ95rwY1zDpgtJ+nn/5C9TcqUv0g6gqXi
	 PMhAato7yp15EkvIArTUUyH4cPBIVBVUsoZ5IygmtQAc0+IJ90UKnJh/tAmxyn1oKVLtg
	 S9J8FC2Def7Iy01QbBu+TJ2UTInPNJ4Yz4Nna6GOrcxKt0EqucyI+y10j6e0SQTXZItMG
	 a89mGbJWG3Ievosp1nni+NDp6raQk2tzJ0zr2H7IKNdISGWBONbePL21P8osmD4vhbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iY3NBSiI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675A606A324
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iY3NBSiI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B91F031E0;
	Wed, 28 Oct 2026 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199450;
	bh=+DrCiC52JWwqxpsEOb10usl2t2DGPyucFM5gOQI8SGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iY3NBSiIZ3d3PYGGfim2CIsJ2sh0aSfuJGHOSrKjxnacHuvSRt/6ZS72bsEGEyMSQ
	 oJ8cDPBnKRU30kGPB7LtBWylOLAdoxqra1y7571Jc3r8Kd/Nlroex6sgc0ybpzJ9Ln
	 L5/bL8O44elME9J3FM2XtmKFoazvTWiG6W49LWw2SAnVnTWzo7GBBGqbWXPQL6ixjo
	 1zeLQ4ui3Eb/h/uPikvrG4mAnIvmGTl0QlzpNKeihkX40fAuVzcPbPqLGUuvh7HyDg
	 +xdvH2SLhlo4AzqldAK1Q6RkQUnKExY4P26tgvC9l5Ba+nXZzIrqjHgZjt/m7kR0q0
	 m4L5gX5UOTr8g==
Message-ID: <sashiko-outbox-188020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261028143534.135968-4-cui.tao@linux.dev>
References: <20261028143534.135968-1-cui.tao@linux.dev>
 <20261028143534.135968-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 14:57:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] selftests/bpf: unused any variable and false test skip in iocost=
_bpf_supported()
- [Medium] selftests/bpf: missing MS_PRIVATE in iocost_test_env() leaks con=
figfs mounts
- [Medium] selftests/bpf: iocost_model attaches to iocost_ioc_tick before i=
t is added
- [Low] selftests/bpf: missing bpf_link__destroy() in serial_test_iocost_mo=
del()
- [Low] selftests/bpf: missing rmdir() on error paths in nullb_create()
--

commit 6b66848245188ed8cc601a3e3e3fb4d06a7f79b3
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

This commit adds two example BPF iocost cost models (a 2x linear HDD model
and a multi-stream sequentiality model) along with selftests exercising
model attachment, switching, pricing, tracepoints, and device removal using
null_blk via configfs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..5373d52d93a66
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
[ ... ]
> +static int nullb_create(const char *name, char *dev, size_t dev_sz)
> +{
> +	char path[128];
> +	char p2[128];
> +	int err;
> +
> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s", name);
> +	if (mkdir(path, 0755)) {
[ ... ]
> +	}
> +
> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s/size", name);
> +	err =3D configfs_write(path, "128");
> +	if (err)
> +		return err;
> +
> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s/power", name);
> +	err =3D configfs_write(path, "1");
> +	if (err)
> +		return err;

[Severity: Low]
Does nullb_create() leak the configfs directory and its underlying
struct nullb_device if writing to the size or power attribute fails?

When mkdir() creates /sys/kernel/config/nullb/<name>, configfs allocates the
device item via nullb_group_make_group(). If either configfs_write() call f=
or
size or power fails, nullb_create() returns early without calling rmdir(pat=
h)
(unlike the read_file_token() failure path below), and callers such as
serial_test_iocost_model() and serial_test_iocost_model_streams() return
immediately without calling nullb_remove().

Should these error paths also remove the created configfs directory before
returning?

[ ... ]
> +static bool iocost_bpf_supported(void)
> +{
> +	FILE *f;
> +	char line[128];
> +	bool any =3D false, on =3D false;
> +
> +	f =3D popen("zcat /proc/config.gz 2>/dev/null", "r");
> +	if (!f)
> +		return false;
> +	while (fgets(line, sizeof(line), f)) {
> +		if (strstr(line, "CONFIG_"))
> +			any =3D true;
> +		if (strstr(line, "CONFIG_BLK_CGROUP_IOCOST_BPF=3Dy"))
> +			on =3D true;
> +	}
> +	pclose(f);
> +	return on;
> +}

[Severity: Medium]
Will iocost_bpf_supported() falsely skip all tests in this file when
/proc/config.gz is not available?

In iocost_bpf_supported(), the local variable any is set when configuration
lines are read from /proc/config.gz, but any is never used in the return
statement (which also triggers an unused-but-set variable warning). Because
tools/testing/selftests/bpf/config does not enable ikconfig in procfs,
popen() succeeds while fgets() reads zero lines when /proc/config.gz or zcat
is absent, leaving both any and on as false.

As a result, iocost_test_env()->iocost_bpf_supported() returns false and sk=
ips
serial_test_iocost_model(), serial_test_iocost_model_streams(), and
serial_test_iocost_model_removal() even when the running kernel has iocost
BPF support enabled.

Was this meant to return !any || on, or check for struct iocost_model_ops in
vmlinux BTF instead?

> +
> +static bool iocost_test_env(void)
> +{
[ ... ]
> +	/* isolate the configfs and cgroup mounts from the host */
> +	if (unshare(CLONE_NEWNS)) {
> +		printf("%s:SKIP:unshare(CLONE_NEWNS) failed: %s\n",
> +		       __func__, strerror(errno));
> +		test__skip();
> +		return false;
> +	}
> +	mkdir("/sys/kernel/config", 0755);
> +	(void)mount("none", "/sys/kernel/config", "configfs", 0, NULL);

[Severity: Medium]
Can this configfs mount in iocost_test_env() propagate back into the host
mount namespace and accumulate across tests?

On systems where / or /sys uses shared mount propagation (the systemd
default), calling unshare() with a new mount namespace followed immediately=
 by
mount() without first setting private mount propagation:

    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL);

causes the new /sys/kernel/config mount to propagate back to the host mount
namespace. In addition, because serial_test_iocost_model(),
serial_test_iocost_model_streams(), and serial_test_iocost_model_removal()
each call iocost_test_env() without unmounting on teardown, three stacked
configfs mounts accumulate on /sys/kernel/config.

[ ... ]
> +void serial_test_iocost_model(void)
> +{
[ ... ]
> +		/*
> +		 * detach implicitly by closing the link fd instead of
> +		 * calling bpf_link__destroy() explicitly: the release
> +		 * path must detach the model just like the explicit
> +		 * call does
> +		 */
> +		lfd =3D bpf_link__fd(skel->links.iocost_2x);
> +		bpf_link__disconnect(skel->links.iocost_2x);
> +		close(lfd);
> +		skel->links.iocost_2x =3D NULL;

[Severity: Low]
Does setting skel->links.iocost_2x =3D NULL here without calling
bpf_link__destroy() leak the struct bpf_link_struct_ops allocation?

In tools/lib/bpf/libbpf.c, bpf_link__disconnect() only marks the link as
disconnected so that bpf_link__destroy() will skip calling link->detach():

    void bpf_link__disconnect(struct bpf_link *link)
    {
        link->disconnected =3D true;
    }

Clearing skel->links.iocost_2x to NULL before bpf_link__destroy() or
iocost_model__destroy(skel) runs prevents link->dealloc() from freeing the
heap-allocated struct bpf_link_struct_ops created by
bpf_map__attach_struct_ops(), which triggers a LeakSanitizer failure under
address sanitizer builds.

> diff --git a/tools/testing/selftests/bpf/progs/iocost_model.c b/tools/tes=
ting/selftests/bpf/progs/iocost_model.c
> new file mode 100644
> index 0000000000000..8875fb0f44174
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iocost_model.c
[ ... ]
> +/* consumes the new iocost_ioc_tick tracepoint from BPF side */
> +SEC("tp_btf/iocost_ioc_tick")
> +__u64 BPF_PROG(iocost_2x_tick_count, struct ioc *ioc,
> +	       const struct ioc_now *now, int nr_active, u64 usage_us_sum)
> +{
> +	ioc_ticks++;
> +	return 0;
> +}

[Severity: Medium]
Does iocost_model__load() fail at this commit because the iocost_ioc_tick
tracepoint has not been introduced yet?

Here iocost_2x_tick_count() is defined with SEC("tp_btf/iocost_ioc_tick") a=
nd
is autoloaded when serial_test_iocost_model() and
serial_test_iocost_model_removal() call iocost_model__load(), and
serial_test_iocost_model() also asserts that skel->bss->ioc_ticks is greater
than zero.

However, the iocost_ioc_tick tracepoint in include/trace/events/iocost.h and
block/blk-iocost.c is only added in the next patch in the series ("blk-ioco=
st:
add iocost_ioc_tick tracepoint for per-period device summary"), so loading =
the
skeleton at this point in the series fails in libbpf_find_attach_btf_id() W=
hen
looking up btf_trace_iocost_ioc_tick.

Should the patch adding the iocost_ioc_tick tracepoint come before this
selftest patch so bisection works cleanly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028143534.1359=
68-1-cui.tao@linux.dev?part=3D3
