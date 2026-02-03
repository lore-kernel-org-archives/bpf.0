Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4E3009DA
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114063; cv=none; b=IBI4mjkO0qKvmmEp8NQ553nhmHc3qHEdaCSvWFTV3PEB/2OjGyoDHnBSjH4ocLgoWImLaj9I+hpdEaHvESoGCw1o1+MmjRmBJLIVQLWZCZWt7/99SjPFSTtjP2Ft9H/7jOzOh0xg+p10jhV8KpNgmsb0El1y0xgHzQ27mS0KOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114063; c=relaxed/simple;
	bh=kGivo3me2lY5yEK48E4ou48eJbyMQGbcKc3pWnb762E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YafijtALQL2Wx/FeR4560WKtdKmV4jqZJpXWDrUC5yHw7Fh1mFjfL2ijrlCdQWzi85c+CFdipj7HCSlwdn7OrDqjNnhXZg3vpzys196qAq6XkyYVvp6ElcoYvVbU44dlt/Pqqi39n14F72kuXfiYabm21Pyi8kZoMoJIJvwZsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rohanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dY46tMJJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rohanka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dY46tMJJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0bb1192cbso46080125ad.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770114061; x=1770718861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Ef/udMn2CSsWbAmEZSNkhhgJ1qm83+e+FEKtRFSJE=;
        b=dY46tMJJAdn5BcvMGGX+EnjPZ1XKXoCHAMJOEzUGFPmXeBW1JGjX2CGHUkgDF9N1GU
         PZZwYzTYNQvUewrRVYH8lhoq9MdBlIA8U+Y3ge1k2t+60DN9FldjjbiTDz8CqH2SjN2P
         wwaFNwtuv4dTFoBwRv/ztzo1q6wo+ntfGO0nx8ZwYDwZPjiRTDXlq9p2Ax2jSWEfwFUJ
         F2HHX6miHgsE8lhpIxTQgYjv2/7fO/eF37cL4iYR3w4VT55zUBoKOc5WtN+wtcaM968C
         D/l1DK113bkNHevBfvg8Zr21n5uXyywHhdAh+lpPVUSslIQin65k4ASHqSiyta2gK6UI
         6tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114061; x=1770718861;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/Ef/udMn2CSsWbAmEZSNkhhgJ1qm83+e+FEKtRFSJE=;
        b=r1OBZuUc+4PDIhVvlTwPEOhw4uENn+1fX7AD2C86plCSuvxwPGetefoD0KnSj/M0qQ
         DbQ+o1GypLFO/AhtD1og0FyFs/CPAKpjoSdx5ekrgSJp3VM/8x4tuPUkv+94s32FmZ4B
         bErND0XTght0PzkJ6OI0l7MwtYQzCL/C9aeuNYtBpas1XDn5HQtoH63ZjFiqO97Y/vcM
         h4tITu1xyUhdAOpeYK2uNCzQYQxs9hyeQpipgVAtKBzzjX4n7EzXypYZy5htkmQVbdJ5
         mcF+jw4furMJ7lq9ykKc3YxFDsM2Xsn+7aTHpOLld3s3ADnNbCZmur12r/Au30INqyP+
         IY9Q==
X-Gm-Message-State: AOJu0YxIZkSdqLTI6oxDJ8ncsrovszYOb8FHeLtHtvfh2FiOSlhD6bUx
	Vl9OBl76kggjYYjC5f5Ht/jdMx52A4U6qKAyfj5ph2+YfN1RMsQT/xgK8N9SHLrkYRD4hXMezF1
	PbJ3oGbHN9NSYMDnFXobhlfT+Odd/ChfTMw8VAsJRueYPeMBLgw+sGQkE9MLQ3mw1rYv4P2dxeP
	88s5t5PHJFNGmtdOn7yJ8BsiUOICZiDlbB5apoPg==
X-Received: from plka13.prod.google.com ([2002:a17:903:f8d:b0:2a7:5b68:f495])
 (user=rohanka job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f06:b0:298:485d:556e
 with SMTP id d9443c01a7336-2a8d959c8b6mr112006655ad.11.1770114061111; Tue, 03
 Feb 2026 02:21:01 -0800 (PST)
Date: Tue,  3 Feb 2026 10:20:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203102058.41030-1-rohanka@google.com>
Subject: [RFC PATCH bpf-next] bpf: ephemeral cgroup BPF control programs
From: Rohan Kakulawaram <rohanka@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Josh Don <joshdon@google.com>, rohanka@google.com
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: quoted-printable

From: rohanka@google.com

Extended Berkeley Packet Filter (eBPF) programs are loadable modules
that can hook onto various contexts within the kernel: kernel
functions, tracepoints, etc. Since these programs are decoupled
from the main kernel binary and can be loaded without a machine
reboot, there is a desire to outsource some of the kernel=E2=80=99s
responsibilities to eBPF for increased flexibility. Furthermore,
eBPF can serve as a bridge between userspace and the kernel by
facilitating access to the kernel=E2=80=99s internal state.

One of the main gaps in achieving these ends, however, is that
there is no infrastructure that supports exposing per cgroup data
via file paths that mirror the cgroupfs hierarchy. This would
allow for a unified source of truth as it relates to accessing
various streams of data related to cgroups. It is important to
note that we would want the fate of these ephemeral files to be
tied to the manipulation of the cgroup tree, such as exposing/
deleting files when creating/removing cgroups respectively.
Cgroup iterators can mimic some of this functionality through
bpffs pins but lack the dynamism of the listed approach.

To elucidate the value of this infra, we note that this would be
instrumental in aiding some of our efforts at Google. For
instance, Borglet, the daemon that manages workloads on each
production machine, repeatedly has to manually parse raw memory
cgroup file from cgroupfs. If we had the capability to directly
expose these stats at each level of the cgroup hierarchy via bpf,
we could forgo some of the expensive parsing associated with the
current approach. Moreover, in the context of upstream efforts,
this infra could be helpful in allowing bpf based schedulers to
expose customized cgroup controls to user space. Overall, this
paradigm of exposing specialized stat files for file systems can
be incredibly valuable in providing robust kernel visibility.

Approach 1: BPFFS Centric
------------------------
This approach introduces a new BPF program type: BPF_PROG_TYPE_CGROUP_STAT.
When such a program is loaded and linked, per-cgroup files are made
available, mirrored under the BPFFS filesystem. For example, an iterator
named "hist_oncpu" would expose data at paths like
/sys/fs/bpf/cgroup/...<cgroup tree>.../hist_oncpu.

To accommodate cgroup-v1 hierarchies, a separate directory, such as
/sys/fs/bpf/cgroup-v1/<controller>/...<memcg_tree>.../memcg_histo,
would be populated for each v1 controller.

Sample read program:

SEC("cgroup/stat")
int histo_on_cpu(struct bpf_iter__cgroup *ctx) {
    struct seq_file *seq =3D ctx->meta->seq;
    struct cgroup *cgrp =3D ctx->cgroup;
    if (cgrp)
        expose_buckets(cgrp, seq);
    return 0;
}

Approach 2: Cgroupfs Centric (Preferred)
-----------------------------------------
This alternative exposes ephemeral files directly within cgroupfs. During
the initial cgroup traversal executed when link_create is called, the
__kernfs_create_file function would be used for every cgroup directory
encountered. The filenames would adhere to a bpf.stat.<program_name>
convention to clearly distinguish them as BPF-managed ephemeral files.

The Case for Approach 2
------------------------
Approach 2 is preferred because it avoids complexities inherent in the
BPFFS-centric approach, such as:

1.Syncing the directory structure between cgroupfs and bpffs
2.Handling the distinct cgroup-v1 and cgroup-v2 hierarchies within bpffs

BPF Syscall Story
-------------------
The primary syscall of interest will be link_create, which is invoked after
the user has loaded the program. Traditionally, bpf links are used to
manage the lifecycle of bpf programs; thus, in this context, we would be
able to switch out the program associated with a link and alter the
ephemeral file content associated with it. Essentially, when the link is
created, analogous to how links are attached to some sort of target, it is
"attached" to the cgroup tree. At this point, the underlying file the
program is supposed to represent is exposed for every cgroup in the
machine. Moreover, the user will pass in the cgroup whose descendants will
expose this ephemeral stat file: attr->link_create.cgroup_root. We will add
the file metadata, including the program link, to a list referenced by
this root cgroup. As discussed in the "Evolving Cgroup Tree" section,
this list will be utilized by cgroup_mkdir and cgroup_rmdir to manage the
lifecycle of ephemeral files within the directories of descendant cgroups.

At a high level here are the file/seq operations we wish to define:

open -> prepare a seq file with seq->private containing the=20
necessary metadata for the program (ie the cgroup)
read -> invoke the seq_show operation on the seq file in file->private
release -> free the seq file and update the bpf program's refcount
seq_show for this file should be relatively simple: we set up the program c=
tx=20
to take in the cgroup pointer, as well as the seq file, and then run=20
the program.

It is important to note that we might need to extend this program to handle
writes, which is a prerequisite for their utility in providing sched_ext
cgroup controls. Please reference the "Potential Feature: File Writes" for
more information on this.

Cgroup Traversal
------------------------
With cgroup_mutex in hand, we will traverse the cgroup tree(s). For each
iteration in approach 1, we check the corresponding level of the bpffs
cgroup tree and see if there is an entry corresponding to our cgroup. To
facilitate this, we can store the dentry of the corresponding bpffs dir
within the cgroup struct. Thus, when we reach a particular cgroup we
invoke lookup_one_qstr_excl using its parent dentry as the base.
Essentially we want to emulate the filename_create without doing a path
resolution for every cgroup we come across. Once we create this new
directory or confirm that it already exists from a previous traversal, we
can add the file using vfs_mkobj with the new set file operations we
mentioned in the previous section.

We must note, this complexity is not present in the cgroupfs-centric
approach as the kernfs_node linked to a cgroup's directory is referenced
by the cgroup itself.

To support both v1 and v2 hierarchies simultaneously, the traversal will go
as follows: we first traverse the default cgroup root to construct the v2
hierarchy, then iterate through all cgroup subsystems to identify those
belonging to the v1 hierarchy and create corresponding subdirectories under
/sys/fs/bpf/cgroup-v1 for each controller. Once again, with the cgroupfs-
centric approach, we do not need to deal with the complexities of these
distinct hierarchies as the cgroup dir, which is accessible in each step
of this traversal, is all we need to create the file.

If we fail during this traversal, we must remove the associated ephemeral
file in bpffs (or cgroupfs) for each visited cgroup. This is handled by
re-walking the hierarchy (in post order for each root). In the bpffs
approach, if no ephemeral files exist in the system on failure, the
directories associated with each cgroup must be removed during this
re-walk.

Evolving Cgroup Tree
------------------------
We also wish to ensure that the ephemeral BPF file hierarchy evolves
alongside the cgroup tree. In the bpffs-centric model, cgroup_mkdir
creates a new directory using the parent bpffs dentry as a base,
populating it with required ephemeral files. Conversely, the cgroupfs-
centric model creates the ephemeral file within the current cgroup
directory. During cgroup_mkdir, the new cgroup traverses each ancestor to
iterate through its associated file list and adds the files to the
appropriate directory in the appropriate filesystem. Additionally, these
operations must ensure that link reference counts are managed precisely to
maintain the persistence of underlying links. Accordingly, cgroup_rmdir
must perform an equivalent traversal of the ephemeral files to decrement
the reference counts for each associated link as they are removed.

Potential Feature: File Writes
--------------------------------
It is possible that we could use this mechanism to enable bpf based
schedulers to expose cgroup controls to userspace. Thus, it is worth
considering allowing for writes via this interface so that user space can
turn these knobs. From an implementation standpoint, we could potentially
use the same program to handle both reads and writes. In that case, the
read/write handlers must provide a program context such that the program
knows which mode it ought to be operating in. For instance, ctx->meta.buffe=
r
can be set to null when the program is in write mode, but in write mode,
it will be populated and used by the program to update some internal state.

Potential Feature: Lazy File Creation
--------------------------------------
Rather than engaging in the complex operation of traversing the cgroup
hierarchy, which carries the intrinsic risk of becoming a system bottleneck
due to the necessity of acquiring the cgroup_mutex, we could create the
ephemeral files when a task attempts to read it. This would potentially
involve modifying the lookup operation in kernfs_dir_iops to invoke some
sort of custom handler after the function attempts to find a file using
kernfs_find_ns. In the case of cgroupfs, this custom handler could traverse
through some sort of red black tree structure containing the ephemeral
files' metadata. If we find the associated file in this tree, we create
the necessary file structures (e.g. inode, kernfs_node, etc.) to support
the file and link it to the containing cgroup's kernfs_node.
