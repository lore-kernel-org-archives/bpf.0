Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6379E4
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 04:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709700373; cv=none; b=eJdYDSEstA63u7G682n6sZ0vzVmaPG6lgTI+ZQcd2G52HmS7wde/fcB5Pnuh0AfCtEPVWS+wjoAmsYvHQ39v1iVZ951TTSnxCwR580wHXTedv4p7K0ApiP/zV7zM5iDDRH5ElkzrKFFYPSmdGcYcOyRAX5LjiLFymOlfR6IX5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709700373; c=relaxed/simple;
	bh=DVKQ/Fm0pvA/jQaMAqirXqycNz2zXZjeMbJrpdQ/1ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhzvjn261Q5UYEw7hevckSgulT6Y275R8g2rivObILvUU93uq6k0wQfzCevH5CRXVU56fP+wh5mWeIR6wIVSsB3ge+TjGjWOj4IdIkwtBWZ7CgiIcYjOZaFOik3Ym19lHug/wOxkU4r/6lS8MhjbvnBAfklZ9DdQde2SW1P3Rnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJcv0woR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJcv0woR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so46199675e9.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 20:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709700369; x=1710305169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDhEGe2Sn3nSetMiWBp7UOcasBXPorXeQt8F0QC1pwc=;
        b=CJcv0woRGrhErLSGeRTH9zqRAc6RLrv6umTYCRpwFrz+VMTeKwQbY4txgVTac4c7Nv
         FoEdoCBWqb9Y7V1fKJ5HZGYCZ1GGSgZzj3mNCEzP/Ayar6XCKkwG6IuDxPGjAfMB5F7E
         JUXJc8gulAh9/j+txAsVl4k6MHEDw1Ob2Nvrb6+tA4RJTfED1LU9MBjo3fwAX0nvbW0u
         GbNJWA/ErLbk1/wQKb2oKiQOxyOc1SgTua2y65XfWWtPd/aU3/GmMunP68HIFr97KOZv
         xRVlxIH8YrQYQwetBZOCkhJw9qS7fPP496rX2fkMV6/yKgnbDIqFQA5SPR8oFMGb1tbM
         CoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709700369; x=1710305169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDhEGe2Sn3nSetMiWBp7UOcasBXPorXeQt8F0QC1pwc=;
        b=K4xEOtlwRZA7x/wXeV0g6727A05rMjTrtsXaF7uoFOboqDIb0919UFsqZB0tqV+SQg
         /18bPQsWH1kpCv3jX6/gSV5OuiZRuATbOEHAri+CqwRZOP1AbYfhccOuGuN2ogvXdTNU
         EYDeStfO9FhtpLomZfL985kYD/aKzZuEg6bkOGVGrzm6fGJg+9BfGxYsjlakqaSe3ZyF
         PppsBvG0Sm0cB39p3x3g3f0m7D3JgrA9a5rVqNwo75ki1PgQlHMm3HYU778Ivb/BeR8H
         T634oxWis/Kz24hxYpSQaEGb/xyzgQ7ueVqO6kzSV4yzkNU67piepL6QSSXGswIMnJR/
         ZBMA==
X-Gm-Message-State: AOJu0YyMsUFTCqaep/XoKNFDpvwyhK6O5jGQDBOh960sHs/Q20h1ejTO
	o7MJcSO6bHq6zPd9mRTmjRtJLadQEZEidkO4ivC/yTVnFv0IermTAlAstbMNU9Jgr1xlgRTPTl4
	m54uWEnNpQkOEXICscrzgpKEgXkfmEUEpWMo=
X-Google-Smtp-Source: AGHT+IEH+2VtdNmDALAeEHNQcpf7jIq6gfBKXhlI1WOhp6DvZNghcWvuva5uunLzbyjbDnAHjFUOjIY2rebltib7gew=
X-Received: by 2002:adf:9ccc:0:b0:33d:277d:a2c7 with SMTP id
 h12-20020adf9ccc000000b0033d277da2c7mr11669997wre.16.1709700368807; Tue, 05
 Mar 2024 20:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8F75EC74-53D6-4841-8D41-4CF56BE69730@isaackhor.com>
In-Reply-To: <8F75EC74-53D6-4841-8D41-4CF56BE69730@isaackhor.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Mar 2024 20:45:56 -0800
Message-ID: <CAADnVQKY0d2ww4hwbuu3TA3DFyrSeBnRqSp0qdEY2Scgf4kP5g@mail.gmail.com>
Subject: Re: struct_ops usage - verifier interactions
To: Isaac Khor <contact@isaackhor.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 8:08=E2=80=AFPM Isaac Khor <contact@isaackhor.com> w=
rote:
>
> I=E2=80=99m a phd student working on adding a new struct_ops type for a p=
otential project, and I have a few questions about its usage.
>
> The background is that we=E2=80=99re thinking of delegating some kernel h=
euristics to bpf programs, and we=E2=80=99re starting with the readahead lo=
gic. The prototype right now just adds an ugly struct_ops right in the midd=
le of the block read path (specifically in read_pages just as a test, will =
probably split out the read vs fault path later) as a test. The patch I hav=
e simply packages up a few readahead control variables already present into=
 a new `bpf_fs_readahead_state` struct and passes that to the struct_ops bp=
f program.
>
> The problem, however, is that the verifier rejects a program that is lite=
rally nothing but `return state->ra_pages`. Any dereference of the passed-i=
n struct lead to a verifier rejection with `R1 invalid mem access =E2=80=98=
scalar=E2=80=99`, complaining that the passed-in pointer is invalid. The re=
gister, when passed to `is_valid_access`, is already of scalar type, so eve=
n a `return true` `is_valid_access` still leads to the rejection.
>
> I=E2=80=99m confused about why the pointer is not a `PTR_TO_BTF_ID`, whic=
h is the case when looking at calls to bpf_cong=E2=80=99s `is_valid_access`=
 when loading bpf_cubic.c. I=E2=80=99m reviewing the fuse-bpf and sched_ext=
 patches, and I don=E2=80=99t see where I need to register my new state str=
uct with the verifier, if that=E2=80=99s indeed what I need to do for the v=
erifier to correctly identify the pointer in `check_mem_access`. I see refe=
rences to special pointer types for tcp_sock in the case of tcp_cong, but n=
ot anything for the fuse-bpf patches.
>
> If there=E2=80=99s documentation somewhere or sample code I should consul=
t please let me know as well.
>
> Here=E2=80=99s my (very ugly, just trying to get it to work) patch is bel=
ow, along with the program I=E2=80=99m trying to load and a verification lo=
g.
>
> ---
>  include/linux/bpf.h |  21 +++++++++
>  mm/Makefile         |   3 ++
>  mm/readahead.c      |  42 +++++++++++++++++
>  mm/readahead_ops.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 178 insertions(+)
>  create mode 100644 mm/readahead_ops.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index c7aa99b44d..0e461d532c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1799,6 +1799,27 @@ struct bpf_dummy_ops {
>         int (*test_sleepable)(struct bpf_dummy_ops_state *cb);
>  };
>
> +// KNN: put it here for now for lack of a better place
> +
> +struct bpf_fs_readahead_state {
> +       int i_ino;
> +       unsigned int size;
> +       unsigned int async_size;
> +       unsigned int ra_pages;
> +       unsigned int mmap_miss;
> +       loff_t prev_pos;
> +};
> +
> +struct bpf_fs_readahead_ops {
> +       int (*get_max_ra)(struct bpf_fs_readahead_state *cb);
> +       int (*get_ra)(struct bpf_fs_readahead_state *cb);
> +};
> +
> +// temporarily globals as we get this working
> +
> +int bpf_fs_ra_register(struct bpf_fs_readahead_ops *ops);
> +void bpf_fs_ra_unregister(struct bpf_fs_readahead_ops *ops);
> +
>  int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr =
*kattr,
>                             union bpf_attr __user *uattr);
>  #endif
> diff --git a/mm/Makefile b/mm/Makefile
> index e4b5b75aae..ccd4287286 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -134,3 +134,6 @@ obj-$(CONFIG_IO_MAPPING) +=3D io-mapping.o
>  obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) +=3D bootmem_info.o
>  obj-$(CONFIG_GENERIC_IOREMAP) +=3D ioremap.o
>  obj-$(CONFIG_SHRINKER_DEBUG) +=3D shrinker_debug.o
> +
> +# TODO use bpf for now
> +obj-$(CONFIG_BPF) +=3D readahead_ops.o
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 23620c57c1..a2c88fb629 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,6 +113,7 @@
>   * ->read_folio() which may be less efficient.
>   */
>
> +#include "linux/bpf.h"
>  #include <linux/blkdev.h>
>  #include <linux/kernel.h>
>  #include <linux/dax.h>
> @@ -143,6 +144,28 @@ file_ra_state_init(struct file_ra_state *ra, struct =
address_space *mapping)
>  }
>  EXPORT_SYMBOL_GPL(file_ra_state_init);
>
> +static struct bpf_fs_readahead_ops *bpf_fs_ra_ops;
> +
> +int bpf_fs_ra_register(struct bpf_fs_readahead_ops *ops)
> +{
> +       if (bpf_fs_ra_ops)
> +               return -EBUSY;
> +
> +       bpf_fs_ra_ops =3D ops;
> +       return 0;
> +}
> +
> +void bpf_fs_ra_unregister(struct bpf_fs_readahead_ops *ops)
> +{
> +       if (bpf_fs_ra_ops =3D=3D ops)
> +               bpf_fs_ra_ops =3D NULL;
> +}
> +
> +/*
> + * There are two ways to get here: from the filemap_read path, or from t=
he
> + * page fault handler for memory-mapped files (filemap_fault). The first=
 will
> + * set up readahead with ondemand_readahead, the second will do ???
> +*/
>  static void read_pages(struct readahead_control *rac)
>  {
>         const struct address_space_operations *aops =3D rac->mapping->a_o=
ps;
> @@ -156,6 +179,25 @@ static void read_pages(struct readahead_control *rac=
)
>                 psi_memstall_enter(&rac->_pflags);
>         blk_start_plug(&plug);
>
> +       // there are two possible places to put this:
> +       // 1. In both the filemap_read and filemap_fault paths, after the=
 call
> +       // determine readahead
> +       // 2. Here, where they both converge after determining readahead.
> +       // Not sure which is better, so I'm leaving it here for now
> +       if (bpf_fs_ra_ops) {
> +               struct bpf_fs_readahead_state state =3D {
> +                       .i_ino =3D rac->mapping->host->i_ino,
> +                       .size =3D rac->ra->size,
> +                       .async_size =3D rac->ra->async_size,
> +                       .ra_pages =3D rac->ra->ra_pages,
> +                       .mmap_miss =3D rac->ra->mmap_miss,
> +                       .prev_pos =3D rac->ra->prev_pos,
> +               };
> +
> +               rac->ra->ra_pages =3D bpf_fs_ra_ops->get_max_ra(&state);
> +               // rac->ra->size =3D bpf_fs_ra_ops->get_ra(&state);
> +       }
> +
>         if (aops->readahead) {
>                 aops->readahead(rac);
>                 /*
> diff --git a/mm/readahead_ops.c b/mm/readahead_ops.c
> new file mode 100644
> index 0000000000..be5de16b88
> --- /dev/null
> +++ b/mm/readahead_ops.c
> @@ -0,0 +1,112 @@
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/bpf_verifier.h>
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/filter.h>
> +
> +static int fs_readahead_get_max_ra_stub(struct bpf_fs_readahead_state *s=
tate)
> +{
> +       return 0;
> +}
> +
> +static int fs_readahead_get_ra_stub(struct bpf_fs_readahead_state *state=
)
> +{
> +       return 0;
> +}
> +
> +struct bpf_fs_readahead_ops knn_readahead =3D {
> +       .get_max_ra =3D fs_readahead_get_max_ra_stub,
> +       .get_ra =3D fs_readahead_get_ra_stub,
> +};
> +
> +// verifier
> +
> +static bool fs_readahead_ops_is_valid_access(int off, int size,
> +                                            enum bpf_access_type type,
> +                                            const struct bpf_prog *prog,
> +                                            struct bpf_insn_access_aux *=
info)
> +{
> +       return true;
> +}
> +
> +static int fs_readahead_btf_struct_access(struct bpf_verifier_log *log,
> +                                         const struct bpf_reg_state *reg=
,
> +                                         int off, int size)
> +{
> +       return 0;
> +}
> +
> +struct bpf_verifier_ops bpf_fs_readahead_verifier_ops =3D {
> +       .get_func_proto =3D NULL,
> +       .is_valid_access =3D fs_readahead_ops_is_valid_access,
> +       .btf_struct_access =3D fs_readahead_btf_struct_access,
> +};
> +
> +// management
> +
> +static int register_bpf_fs_ra(void *kdata)
> +{
> +       printk(KERN_ALERT "register_bpf_fs_ra\n");
> +       return bpf_fs_ra_register(kdata);
> +}
> +
> +static void unregister_bpf_fs_ra(void *kdata)
> +{
> +       printk(KERN_ALERT "unregister_bpf_fs_ra\n");
> +       bpf_fs_ra_unregister(kdata);
> +}
> +
> +static int bpf_fs_ra_check_member(const struct btf_type *t,
> +                                  const struct btf_member *member,
> +                                  const struct bpf_prog *prog)
> +{
> +       return 0;
> +}
> +
> +static int bpf_fs_ra_init_member(const struct btf_type *t,
> +                                const struct btf_member *member,
> +                                void *kdata, const void *udata)
> +{
> +       // no-op for now
> +       return 0;
> +}
> +
> +static struct btf *bpf_fs_ra_btf;
> +
> +static int bpf_fs_ra_init(struct btf *btf)
> +{
> +       bpf_fs_ra_btf =3D btf;
> +       return 0;
> +}
> +
> +static struct bpf_struct_ops bpf_fs_readahead_ops_struct =3D {
> +       .verifier_ops =3D &bpf_fs_readahead_verifier_ops,
> +       .reg =3D register_bpf_fs_ra,
> +       .unreg =3D unregister_bpf_fs_ra,
> +       .update =3D NULL, // cannot be updated
> +       .check_member =3D bpf_fs_ra_check_member,
> +       .init_member =3D bpf_fs_ra_init_member,
> +       .init =3D bpf_fs_ra_init,
> +       .validate =3D NULL,
> +
> +       .name =3D "bpf_fs_readahead_ops",
> +       .cfi_stubs =3D &knn_readahead,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static void noop(void *p)
> +{
> +       // no-op
> +}
> +
> +static int __init bpf_fs_ra_kfunc_init(void)
> +{
> +       int ret =3D 0;
> +       noop(&bpf_fs_readahead_ops_struct);
> +       ret =3D register_bpf_struct_ops(&bpf_fs_readahead_ops_struct,
> +                                         bpf_fs_readahead_ops);
> +       return ret;
> +}
> +late_initcall(bpf_fs_ra_kfunc_init);
> --
> 2.34.1
>
> And also the bpf program I=E2=80=99m trying to load:
>
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include <linux/bpf.h>
>
> char _license[] SEC("license") =3D "GPL";
>
> SEC("struct_ops/bpf_iden_max_ra")
> int BPF_PROG(bpf_iden_max_ra, struct bpf_fs_readahead_state *s)
> {
>     return s->ra_pages;
> }
>
> SEC("struct_ops/bpf_iden_ra")
> int BPF_PROG(bpf_iden_ra, struct bpf_fs_readahead_state *s)
> {
>     return s->size;
> }
>
> SEC(".struct_ops")
> struct bpf_fs_readahead_ops bpf_fs_readahead_ops =3D {
>     .get_max_ra =3D (void *)bpf_iden_max_ra,
>     .get_ra =3D (void *)bpf_iden_ra,
> };
>
> And the verification log:
>
> + bpftool struct_ops register /root/readahead_noop.o
> libbpf: prog 'bpf_iden_max_ra': BPF program load failed: Permission denie=
d
> libbpf: prog 'bpf_iden_max_ra': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int BPF_PROG(bpf_iden_max_ra, struct bpf_fs_readahead_state *s) @ reada=
head_noop.c:8
> 0: (7b) *(u64 *)(r10 -8) =3D r1         ; R1=3Dctx() R10=3Dfp0 fp-8_w=3Dc=
tx()
> 1: (79) r2 =3D *(u64 *)(r1 +0)          ; R1=3Dctx() R2_w=3Dscalar()
> 2: (85) call pc+1
> caller:
>  R10=3Dfp0 fp-8_w=3Dctx()
> callee:
>  frame1: R1=3Dctx() R2_w=3Dscalar() R10=3Dfp0
> 4: frame1: R1=3Dctx() R2_w=3Dscalar() R10=3Dfp0
> 4: (7b) *(u64 *)(r10 -8) =3D r1         ; frame1: R1=3Dctx() R10=3Dfp0 fp=
-8_w=3Dctx()
> 5: (7b) *(u64 *)(r10 -16) =3D r2        ; frame1: R2_w=3Dscalar(id=3D1) R=
10=3Dfp0 fp-16_w=3Dscalar(id=3D1)
> ; return s->ra_pages; @ readahead_noop.c:10
> 6: (61) r0 =3D *(u32 *)(r2 +12)
> R2 invalid mem access 'scalar'
> processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'bpf_iden_max_ra': failed to load: -13
> libbpf: failed to load object '/root/readahead_noop.o=E2=80=99

Was it compiled with -O0 ?
clang didn't even inline what was marked as __always_inline which is strang=
e.
Make sure to use the latest clang with -O2 -target bpf -g -mcpu=3Dv3

You should see something like:

llvm-objdump -S -r bpf_cubic.bpf.o|head -50

bpf_cubic.bpf.o:    file format elf64-bpf

Disassembly of section struct_ops/bpf_cubic_init:

0000000000000000 <bpf_cubic_init>:
; void BPF_PROG(bpf_cubic_init, struct sock *sk)
       0:    79 12 00 00 00 00 00 00    r2 =3D *(u64 *)(r1 + 0x0)
       1:    b7 03 00 00 20 00 00 00    r3 =3D 0x20
        0000000000000008:  CO-RE <byte_off> [5] struct
inet_connection_sock::icsk_ca_priv (0:5)
       2:    bf 21 00 00 00 00 00 00    r1 =3D r2
       3:    0f 31 00 00 00 00 00 00    r1 +=3D r3
       4:    b7 03 00 00 00 00 00 00    r3 =3D 0x0
;     ca->last_max_cwnd =3D 0;
       5:    63 31 04 00 00 00 00 00    *(u32 *)(r1 + 0x4) =3D r3
       6:    63 32 20 00 00 00 00 00    *(u32 *)(r2 + 0x20) =3D r3
        0000000000000030:  CO-RE <byte_off> [5] struct
inet_connection_sock::icsk_ca_priv (0:5)
       7:    63 31 0c 00 00 00 00 00    *(u32 *)(r1 + 0xc) =3D r3
       8:    63 31 08 00 00 00 00 00    *(u32 *)(r1 + 0x8) =3D r3
