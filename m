Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993DF14F68
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698090; cv=none; b=apDh/HnPDYfCLo9mLKfskNGXs89wDpYW2Ne+z8VVeZcsR8ZAsc4gmA55G814/nIoJ00kDw2XfrRbuBhT3hn4LYmozbgAqEObv1wu/nDPDw2rencrBxvdmVhkBMMPQLHtD40BK/6zF4DOxa2WBqmDcfTubKaz8FmZo+cVBSoMIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698090; c=relaxed/simple;
	bh=amRNbL8SBd4wyuAHVhRPH4XnhhwDrSXRQAqxEHWx5qI=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=DvYuGSElpTOzEKCqjAUFL7RaHDp5EsxMnQwRvMTxNnIrQbf+vfsKrqwvigB8FSo1YsivigqX5kCn875h1yDa68l1nrKvLPt+1KZt5HbYi3NhffadCvweKu+muo8E6Sbr40ysopWr7WN+u3crx6piwi8t/hrKq15lPCEXtVH8WS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isaackhor.com; spf=pass smtp.mailfrom=isaackhor.com; dkim=pass (2048-bit key) header.d=isaackhor.com header.i=@isaackhor.com header.b=AXs/pkRt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FURGOYsg; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isaackhor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isaackhor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isaackhor.com header.i=@isaackhor.com header.b="AXs/pkRt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FURGOYsg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 78B111800074
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 23:08:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 05 Mar 2024 23:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isaackhor.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1709698085; x=1709784485; bh=EE
	yw8WoskKHM4GsHyZdX3Saunvdz3YaOQRn8HfC/7Ss=; b=AXs/pkRtKrR7yhxJzb
	B5XhVXkhrTcA7a71S79MtdJlwsSbO2abFoOJB7Z2rjWwYzSyM9trhmFJxFAa6UZ7
	clu5jHjKAjFHuJTbjadkMu0Sno8hoiSH+wpFNP13cCfQd2QgHOMKKesSAtIuYUd5
	//n1aPTAvXGYPDTOJwUf2gBvWye+Dvs7rDeDRf3DqQbaDr/r8TZzWFjL9NkosAM4
	0pDd5JQEIkKNQjkSLJsl44WmDErFMJBImfHORsfFyRAzo0iabmajYBeAaammn2lh
	iVwseIC+w9+xml8m7BxHRxJOeiEOFisMS9aDvJ2Ufam+YTmM1+Zt8omsxnnUE32m
	mHGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709698085; x=1709784485; bh=EEyw8WoskKHM4GsHyZdX3Saunvdz
	3YaOQRn8HfC/7Ss=; b=FURGOYsg2lobWC7CtY4R/jVtUSpLg7cwPYRYB4Wwt+9r
	XjMgNwZLHPu5P9whbgXvpCyKmqruK07k2N/aymhoQkjFOzKqHY0t6PbNmEdnn1CV
	tHgiZBrg7iMGC+EtKhT2qz6OMOvubLzmEs029PLwDpJHIwTsCJvPKsS7bIhLd/ND
	GUeFGGkPzsMyk1LDMuq9jiAMkXmx/hvQf0F3upHBrTuQ7KvqdpWvufSv9EF7hDhn
	Um1NlNuFctflr7eQgQji3ryQ39rL1DJJOXcxWlztZkcMbqk3db+afiZAnKaq23Gv
	usllQFRKCjQ1WEGVEv5LE/py8vpYzWNPxYJ3R/MvoQ==
X-ME-Sender: <xms:JeznZQ2F3OLSgRtU4Aq32H0_vQEABJiB1PuSFDFXS1WU5D-atVC27A>
    <xme:JeznZbFwYO32SEAthPpWs-a7OTBwBfGR4j1Ln3yDCxhucwN6OJ2-SsTSE_RCATkTz
    zO7eMIj2rXeBkGVepY>
X-ME-Received: <xmr:JeznZY5Z2w9cXnbH3fUZNkfHvrDSBy6W5CVt0-nSUh23WVGYDd8eJDfAnP7BsspaYhQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmhdthh
    dtjeenucfhrhhomhepkfhsrggrtgcumfhhohhruceotghonhhtrggtthesihhsrggrtghk
    hhhorhdrtghomheqnecuggftrfgrthhtvghrnhepteekieeileeiffdufedufeffgeeuud
    etkeelheeigfehudethfffjeelgfetheeinecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtoh
    hnthgrtghtsehishgrrggtkhhhohhrrdgtohhm
X-ME-Proxy: <xmx:JeznZZ0hpsobWph5IJYUTi-FGyKDwKHI-ePnGXkVlaFbZyDz3Iy7zA>
    <xmx:JeznZTEi7-kMs-4_rn22Ea7HB5zFXFpNt7Ziscobb_Lia4ZwlZrOog>
    <xmx:JeznZS8xnPdiRIS-hNS4rjOOlxmyNUqAYYaMpASznhtmBVRzhjffTA>
    <xmx:JeznZZPjUshiRyXvS4KxLloDzjKa_79Q0ZT2PeB1xkRJTU-2bEWFH5lE1ww>
Feedback-ID: ia46944cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <bpf@vger.kernel.org>; Tue, 5 Mar 2024 23:08:05 -0500 (EST)
From: Isaac Khor <contact@isaackhor.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: struct_ops usage - verifier interactions
Message-Id: <8F75EC74-53D6-4841-8D41-4CF56BE69730@isaackhor.com>
Date: Tue, 5 Mar 2024 23:07:54 -0500
To: bpf@vger.kernel.org
X-Mailer: Apple Mail (2.3774.300.61.1.2)

I=E2=80=99m a phd student working on adding a new struct_ops type for a =
potential project, and I have a few questions about its usage.

The background is that we=E2=80=99re thinking of delegating some kernel =
heuristics to bpf programs, and we=E2=80=99re starting with the =
readahead logic. The prototype right now just adds an ugly struct_ops =
right in the middle of the block read path (specifically in read_pages =
just as a test, will probably split out the read vs fault path later) as =
a test. The patch I have simply packages up a few readahead control =
variables already present into a new `bpf_fs_readahead_state` struct and =
passes that to the struct_ops bpf program.

The problem, however, is that the verifier rejects a program that is =
literally nothing but `return state->ra_pages`. Any dereference of the =
passed-in struct lead to a verifier rejection with `R1 invalid mem =
access =E2=80=98scalar=E2=80=99`, complaining that the passed-in pointer =
is invalid. The register, when passed to `is_valid_access`, is already =
of scalar type, so even a `return true` `is_valid_access` still leads to =
the rejection.

I=E2=80=99m confused about why the pointer is not a `PTR_TO_BTF_ID`, =
which is the case when looking at calls to bpf_cong=E2=80=99s =
`is_valid_access` when loading bpf_cubic.c. I=E2=80=99m reviewing the =
fuse-bpf and sched_ext patches, and I don=E2=80=99t see where I need to =
register my new state struct with the verifier, if that=E2=80=99s indeed =
what I need to do for the verifier to correctly identify the pointer in =
`check_mem_access`. I see references to special pointer types for =
tcp_sock in the case of tcp_cong, but not anything for the fuse-bpf =
patches.

If there=E2=80=99s documentation somewhere or sample code I should =
consult please let me know as well.

Here=E2=80=99s my (very ugly, just trying to get it to work) patch is =
below, along with the program I=E2=80=99m trying to load and a =
verification log.

---
 include/linux/bpf.h |  21 +++++++++
 mm/Makefile         |   3 ++
 mm/readahead.c      |  42 +++++++++++++++++
 mm/readahead_ops.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 mm/readahead_ops.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c7aa99b44d..0e461d532c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1799,6 +1799,27 @@ struct bpf_dummy_ops {
 	int (*test_sleepable)(struct bpf_dummy_ops_state *cb);
 };
=20
+// KNN: put it here for now for lack of a better place
+
+struct bpf_fs_readahead_state {
+	int i_ino;
+	unsigned int size;
+	unsigned int async_size;
+	unsigned int ra_pages;
+	unsigned int mmap_miss;
+	loff_t prev_pos;
+};
+
+struct bpf_fs_readahead_ops {
+	int (*get_max_ra)(struct bpf_fs_readahead_state *cb);
+	int (*get_ra)(struct bpf_fs_readahead_state *cb);
+};
+
+// temporarily globals as we get this working
+
+int bpf_fs_ra_register(struct bpf_fs_readahead_ops *ops);
+void bpf_fs_ra_unregister(struct bpf_fs_readahead_ops *ops);
+
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr =
*kattr,
 			    union bpf_attr __user *uattr);
 #endif
diff --git a/mm/Makefile b/mm/Makefile
index e4b5b75aae..ccd4287286 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -134,3 +134,6 @@ obj-$(CONFIG_IO_MAPPING) +=3D io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) +=3D bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) +=3D ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) +=3D shrinker_debug.o
+
+# TODO use bpf for now
+obj-$(CONFIG_BPF) +=3D readahead_ops.o
diff --git a/mm/readahead.c b/mm/readahead.c
index 23620c57c1..a2c88fb629 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,6 +113,7 @@
  * ->read_folio() which may be less efficient.
  */
=20
+#include "linux/bpf.h"
 #include <linux/blkdev.h>
 #include <linux/kernel.h>
 #include <linux/dax.h>
@@ -143,6 +144,28 @@ file_ra_state_init(struct file_ra_state *ra, struct =
address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
=20
+static struct bpf_fs_readahead_ops *bpf_fs_ra_ops;
+
+int bpf_fs_ra_register(struct bpf_fs_readahead_ops *ops)
+{
+	if (bpf_fs_ra_ops)
+		return -EBUSY;
+
+	bpf_fs_ra_ops =3D ops;
+	return 0;
+}
+
+void bpf_fs_ra_unregister(struct bpf_fs_readahead_ops *ops)
+{
+	if (bpf_fs_ra_ops =3D=3D ops)
+		bpf_fs_ra_ops =3D NULL;
+}
+
+/*
+ * There are two ways to get here: from the filemap_read path, or from =
the
+ * page fault handler for memory-mapped files (filemap_fault). The =
first will=20
+ * set up readahead with ondemand_readahead, the second will do ???
+*/
 static void read_pages(struct readahead_control *rac)
 {
 	const struct address_space_operations *aops =3D =
rac->mapping->a_ops;
@@ -156,6 +179,25 @@ static void read_pages(struct readahead_control =
*rac)
 		psi_memstall_enter(&rac->_pflags);
 	blk_start_plug(&plug);
=20
+	// there are two possible places to put this:
+	// 1. In both the filemap_read and filemap_fault paths, after =
the call
+	// determine readahead
+	// 2. Here, where they both converge after determining =
readahead.
+	// Not sure which is better, so I'm leaving it here for now
+	if (bpf_fs_ra_ops) {
+		struct bpf_fs_readahead_state state =3D {
+			.i_ino =3D rac->mapping->host->i_ino,
+			.size =3D rac->ra->size,
+			.async_size =3D rac->ra->async_size,
+			.ra_pages =3D rac->ra->ra_pages,
+			.mmap_miss =3D rac->ra->mmap_miss,
+			.prev_pos =3D rac->ra->prev_pos,
+		};
+
+		rac->ra->ra_pages =3D bpf_fs_ra_ops->get_max_ra(&state);
+		// rac->ra->size =3D bpf_fs_ra_ops->get_ra(&state);
+	}
+
 	if (aops->readahead) {
 		aops->readahead(rac);
 		/*
diff --git a/mm/readahead_ops.c b/mm/readahead_ops.c
new file mode 100644
index 0000000000..be5de16b88
--- /dev/null
+++ b/mm/readahead_ops.c
@@ -0,0 +1,112 @@
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+
+static int fs_readahead_get_max_ra_stub(struct bpf_fs_readahead_state =
*state)
+{
+	return 0;
+}
+
+static int fs_readahead_get_ra_stub(struct bpf_fs_readahead_state =
*state)
+{
+	return 0;
+}
+
+struct bpf_fs_readahead_ops knn_readahead =3D {
+	.get_max_ra =3D fs_readahead_get_max_ra_stub,
+	.get_ra =3D fs_readahead_get_ra_stub,
+};
+
+// verifier
+
+static bool fs_readahead_ops_is_valid_access(int off, int size,
+					     enum bpf_access_type type,
+					     const struct bpf_prog =
*prog,
+					     struct bpf_insn_access_aux =
*info)
+{
+	return true;
+}
+
+static int fs_readahead_btf_struct_access(struct bpf_verifier_log *log,
+					  const struct bpf_reg_state =
*reg,
+					  int off, int size)
+{
+	return 0;
+}
+
+struct bpf_verifier_ops bpf_fs_readahead_verifier_ops =3D {
+	.get_func_proto =3D NULL,
+	.is_valid_access =3D fs_readahead_ops_is_valid_access,
+	.btf_struct_access =3D fs_readahead_btf_struct_access,
+};
+
+// management
+
+static int register_bpf_fs_ra(void *kdata)
+{
+	printk(KERN_ALERT "register_bpf_fs_ra\n");
+	return bpf_fs_ra_register(kdata);
+}
+
+static void unregister_bpf_fs_ra(void *kdata)
+{
+	printk(KERN_ALERT "unregister_bpf_fs_ra\n");
+	bpf_fs_ra_unregister(kdata);
+}
+
+static int bpf_fs_ra_check_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   const struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static int bpf_fs_ra_init_member(const struct btf_type *t,
+				 const struct btf_member *member,
+				 void *kdata, const void *udata)
+{
+	// no-op for now
+	return 0;
+}
+
+static struct btf *bpf_fs_ra_btf;
+
+static int bpf_fs_ra_init(struct btf *btf)
+{
+	bpf_fs_ra_btf =3D btf;
+	return 0;
+}
+
+static struct bpf_struct_ops bpf_fs_readahead_ops_struct =3D {
+	.verifier_ops =3D &bpf_fs_readahead_verifier_ops,
+	.reg =3D register_bpf_fs_ra,
+	.unreg =3D unregister_bpf_fs_ra,
+	.update =3D NULL, // cannot be updated
+	.check_member =3D bpf_fs_ra_check_member,
+	.init_member =3D bpf_fs_ra_init_member,
+	.init =3D bpf_fs_ra_init,
+	.validate =3D NULL,
+
+	.name =3D "bpf_fs_readahead_ops",
+	.cfi_stubs =3D &knn_readahead,
+	.owner =3D THIS_MODULE,
+};
+
+static void noop(void *p)
+{
+	// no-op
+}
+
+static int __init bpf_fs_ra_kfunc_init(void)
+{
+	int ret =3D 0;
+	noop(&bpf_fs_readahead_ops_struct);
+	ret =3D register_bpf_struct_ops(&bpf_fs_readahead_ops_struct,
+					  bpf_fs_readahead_ops);
+	return ret;
+}
+late_initcall(bpf_fs_ra_kfunc_init);
--=20
2.34.1

And also the bpf program I=E2=80=99m trying to load:

#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
#include <linux/bpf.h>

char _license[] SEC("license") =3D "GPL";

SEC("struct_ops/bpf_iden_max_ra")
int BPF_PROG(bpf_iden_max_ra, struct bpf_fs_readahead_state *s)
{
    return s->ra_pages;
}

SEC("struct_ops/bpf_iden_ra")
int BPF_PROG(bpf_iden_ra, struct bpf_fs_readahead_state *s)
{
    return s->size;
}

SEC(".struct_ops")
struct bpf_fs_readahead_ops bpf_fs_readahead_ops =3D {
    .get_max_ra =3D (void *)bpf_iden_max_ra,
    .get_ra =3D (void *)bpf_iden_ra,
};

And the verification log:

+ bpftool struct_ops register /root/readahead_noop.o
libbpf: prog 'bpf_iden_max_ra': BPF program load failed: Permission =
denied
libbpf: prog 'bpf_iden_max_ra': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; int BPF_PROG(bpf_iden_max_ra, struct bpf_fs_readahead_state *s) @ =
readahead_noop.c:8
0: (7b) *(u64 *)(r10 -8) =3D r1         ; R1=3Dctx() R10=3Dfp0 =
fp-8_w=3Dctx()
1: (79) r2 =3D *(u64 *)(r1 +0)          ; R1=3Dctx() R2_w=3Dscalar()
2: (85) call pc+1
caller:
 R10=3Dfp0 fp-8_w=3Dctx()
callee:
 frame1: R1=3Dctx() R2_w=3Dscalar() R10=3Dfp0
4: frame1: R1=3Dctx() R2_w=3Dscalar() R10=3Dfp0
4: (7b) *(u64 *)(r10 -8) =3D r1         ; frame1: R1=3Dctx() R10=3Dfp0 =
fp-8_w=3Dctx()
5: (7b) *(u64 *)(r10 -16) =3D r2        ; frame1: R2_w=3Dscalar(id=3D1) =
R10=3Dfp0 fp-16_w=3Dscalar(id=3D1)
; return s->ra_pages; @ readahead_noop.c:10
6: (61) r0 =3D *(u32 *)(r2 +12)
R2 invalid mem access 'scalar'
processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'bpf_iden_max_ra': failed to load: -13
libbpf: failed to load object '/root/readahead_noop.o=E2=80=99

Also available on GitHub at https://github.com/Khoury-srg/KernelNN.

Thanks,
Isaac Khor

